import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_tracker/theme/theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../ngo/ngo_campaign/campaign_model.dart';
import '../../widget/custom_textfield.dart';

class CampaignManagementScreen extends StatelessWidget {
  const CampaignManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ngoId = FirebaseAuth.instance.currentUser!.uid;
    TextEditingController _searchController = TextEditingController();

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('campaigns')
            .where('ngoId', isEqualTo: ngoId)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No campaigns to manage.'));
          }

          final campaigns = snapshot.data!.docs.map((doc) {
            return NgoCampaignModel.fromMap(
                doc.data() as Map<String, dynamic>, doc.id);
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CustomTextfield(
                    controller: _searchController,
                    icon: const Icon(Icons.search),
                    labeltext: 'Search',
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: campaigns.length,
                    itemBuilder: (context, index) {
                      final campaign = campaigns[index];
                      final progress =
                          (campaign.donatedAmount / campaign.targetAmount)
                              .clamp(0.0, 1.0);
                      final formattedDate = DateFormat('MMMM dd, yyyy')
                          .format(campaign.createdAt.toDate());

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              campaign.imageUrl,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title
                                  Text(
                                    campaign.title,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    campaign.description,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 8),
                                  // Raised and Target Amounts
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Raised: \$${campaign.donatedAmount}',
                                        style: const TextStyle(
                                            color: Themes.primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(
                                        'Target: \$${campaign.targetAmount}',
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor: Colors.grey[300],
                                    color: Themes.secondaryColor,
                                  ),
                                  const SizedBox(height: 8),
                                  // Status and Date
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.green[100],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'Active',
                                          style: TextStyle(
                                              color: Colors.green[700],
                                              fontSize: 12),
                                        ),
                                      ),
                                      Text(
                                        'Created: $formattedDate',
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
