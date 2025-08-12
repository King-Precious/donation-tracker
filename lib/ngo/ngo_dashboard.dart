// File: lib/ngo/ngo_dashboard.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_tracker/ngo/ngo_campaign/create_campaign_screen.dart';
import 'package:donation_tracker/ngo/ngo_history/ngo_donation_screen.dart';
import 'package:donation_tracker/theme/theme_colors.dart';
import 'package:donation_tracker/widget/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'ngo_history/ngo_history_model.dart';



class NgoDashboard extends StatelessWidget {
  NgoDashboard({super.key});

  // Helper method to build the summary card
  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Themes.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Themes.primaryColor),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ngoId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Summary Cards Section
              StreamBuilder<QuerySnapshot>(
                // Stream for all campaigns to get the total count
                stream: FirebaseFirestore.instance
                    .collection('campaigns')
                    .where('ngoId', isEqualTo: ngoId)
                    .snapshots(),
                builder: (context, campaignSnapshot) {
                  return StreamBuilder<QuerySnapshot>(
                    // Stream for all donations to get the total raised amount
                    stream: FirebaseFirestore.instance
                        .collection('donations')
                        .where('ngoId', isEqualTo: ngoId)
                        .snapshots(),
                    builder: (context, donationSnapshot) {
                      if (!campaignSnapshot.hasData || !donationSnapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final totalCampaigns = campaignSnapshot.data!.docs.length;
                      final totalRaised = donationSnapshot.data!.docs.fold<int>(0, (sum, doc) => sum + (doc['amount'] as int? ?? 0));

                      return Column(
                        children: [
                          CustomTextfield(
                            controller: _searchController,
                            icon: const Icon(Icons.search),
                            labeltext: 'Search',
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildSummaryCard(
                                title: 'Total Campaigns',
                                value: totalCampaigns.toString(),
                                icon: Icons.local_activity_outlined,
                              ),
                              const SizedBox(width: 16),
                              _buildSummaryCard(
                                title: 'Funds Raised',
                                value: '\$${totalRaised.toStringAsFixed(2)}',
                                icon: Icons.payments_outlined,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 24),

              // 2. Recent Donations Section
              Row(
                children: [
                  const Text(
                    'Recent Donations',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NgoDonationHistoryScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('donations')
                    .where('ngoId', isEqualTo: ngoId)
                    .orderBy('donationDate', descending: true)
                    .limit(5) // Get only a few recent donations
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Text('No donations received yet.', style: TextStyle(color: Colors.grey));
                  }

                  final donations = snapshot.data!.docs.map((doc) {
                    return Donation.fromMap(doc.data() as Map<String, dynamic>, doc.id);
                  }).toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: donations.length,
                    itemBuilder: (context, index) {
                      final donation = donations[index];
                      final formattedDate = DateFormat('MMMM dd, yyyy').format(donation.donationDate.toDate());
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: const Icon(Icons.favorite, color: Themes.secondaryColor),
                          title: Text('Donated to ${donation.campaignTitle}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            'Amount: \$${donation.amount.toStringAsFixed(2)} | Date: $formattedDate',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateCampaignScreen(),
            ),
          );
        },
        backgroundColor: Themes.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}