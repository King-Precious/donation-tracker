import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_tracker/donor/donate_history/donor_history_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/theme_colors.dart';
import '../../donor/donate_history/history_card.dart';

class DonationHistory extends StatelessWidget {
  const DonationHistory({super.key});

  Widget _buildSummaryCard(List<Donation> donations) {
    // Note: totalAmount is calculated from all donations fetched in the stream.
    double totalAmount = 0.0;
    for (var donation in donations) {
      // Assuming donation.amount is accessible and convertable to double
      totalAmount += donation.amount.toDouble(); 
    }

    return Container(
      height: 130,
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Themes.borderColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            // Changed title to reflect general data
            'Total Donations in System',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '\$${totalAmount.toStringAsFixed(2)}', 
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Themes.secondaryColor,
            ),
          ),
          Text(
            'Across ${donations.length} total transactions', // Changed subtitle
            style: const TextStyle(
              fontSize: 12,
              color: Themes.borderColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🛑 REMOVED: final currentUser = FirebaseAuth.instance.currentUser;
    // 🛑 REMOVED: The null check for currentUser and the error message.
    
    // Now, the widget always attempts to load data, regardless of the user's login status.
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('donations')
            // 🛑 REMOVED: .where('donorId', isEqualTo: userId)
            // The stream now fetches ALL donations.
            .orderBy('donationDate', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                // Changed message to reflect general data
                child: Text('No donations have been recorded yet.'));
          }

          final donations = snapshot.data!.docs.map((doc) {
            // Note: If the Donation model relies on user data for its properties, 
            // you may need to adjust the model as well.
            return Donation.fromMap(doc.data(), doc.id);
          }).toList();

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryCard(donations),
                  const SizedBox(height: 17),
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: donations.length,
                    itemBuilder: (context, index) {
                      final donation = donations[index];
                      final formattedDate = DateFormat('MMMM dd, yyyy')
                          .format(donation.donationDate.toDate());

                      return HistoryCard(
                        title: donation.campaignTitle,
                        subtitle: donation.subtitle,
                        date: formattedDate,
                        amount:
                            '\$${donation.amount.toStringAsFixed(2)}',
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}