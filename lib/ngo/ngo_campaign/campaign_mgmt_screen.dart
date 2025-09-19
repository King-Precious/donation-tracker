// File: lib/ngo/campaign/campaign_management_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_tracker/theme/theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../ngo/ngo_campaign/campaign_model.dart';
import '../../widget/custom_textfield.dart';
import 'create_campaign_screen.dart'; // Import your create screen

class CampaignManagementScreen extends StatefulWidget {
  const CampaignManagementScreen({super.key});

  @override
  State<CampaignManagementScreen> createState() =>
      _CampaignManagementScreenState();
}

class _CampaignManagementScreenState extends State<CampaignManagementScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ngoId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextfield(
              controller: _searchController,
              icon: const Icon(Icons.search),
              labeltext: 'Search Campaigns',
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
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

                // Filter the list based on the search query
                final filteredCampaigns = campaigns.where((campaign) {
                  return campaign.title.toLowerCase().contains(_searchQuery.toLowerCase());
                }).toList();

                if (filteredCampaigns.isEmpty) {
                  return const Center(child: Text('No matching campaigns found.'));
                }

                return ListView.builder(
                  itemCount: filteredCampaigns.length,
                  itemBuilder: (context, index) {
                    final campaign = filteredCampaigns[index];
                    final progress = (campaign.donatedAmount / campaign.targetAmount)
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
                          // if (campaign.imageUrl != null && campaign.imageUrl!.isNotEmpty)
                          //   Image.network(
                          //     campaign.imageUrl!,
                          //     fit: BoxFit.cover,
                          //     width: double.infinity,
                          //     height: 150,
                          //     errorBuilder: (context, error, stackTrace) =>
                          //         const SizedBox(
                          //             height: 150,
                          //             child: Center(
                          //                 child: Icon(Icons.image_not_supported))),
                          //   ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Raised: \$${campaign.donatedAmount.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          color: Themes.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Target: \$${campaign.targetAmount.toStringAsFixed(2)}',
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}