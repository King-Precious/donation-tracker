import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_tracker/donor/donate_history/donor_history_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/theme_colors.dart';
import '../../donor/donate_history/history_card.dart';

class DonationHistory extends StatelessWidget {
  const DonationHistory({super.key});

  
  Widget _buildSummaryCard(List<Donation> donations) {
    int totalAmount = 0;
    for (var donation in donations) {
      totalAmount += donation.amount;
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
            'Total Donations Made',
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
            'Across ${donations.length} campaigns',
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
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('donations')
            .where('donorId', isEqualTo: userId)
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
                child: Text('You have not made any donations yet.'));
          }

          final donations = snapshot.data!.docs.map((doc) {
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
