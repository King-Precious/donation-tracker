import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_tracker/donor/campaigns/campaign_details.dart' show CampaignDetailsScreen;
import 'package:flutter/material.dart';
import 'package:donation_tracker/donor/campaigns/campaign_reuse_card.dart';

// import '../theme/theme_colors.dart';
import '../../widget/custom_textfield.dart';
import 'camp_model.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({super.key});

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  final TextEditingController _searchController = TextEditingController();
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Active Campaigns',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CustomTextfield(
                  controller: _searchController,
                  icon: const Icon(Icons.search),
                  labeltext: 'Search Campaigns...',
                ),
                const SizedBox(height: 20),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('campaigns')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No campaigns found.'));
                      }

                      final allCampaigns = snapshot.data!.docs.map((doc) {
                        return Campaign.fromMap(
                            doc.data() as Map<String, dynamic>, doc.id);
                      }).toList();

                      final filteredCampaigns = allCampaigns.where((campaign) {
                        final query = _searchQuery.toLowerCase();
                        return campaign.title.toLowerCase().contains(query) ||
                            campaign.description
                                .toLowerCase()
                                .contains(query) ||
                            campaign.category.toLowerCase().contains(query);
                      }).toList();

                      if (filteredCampaigns.isEmpty) {
                        return const Center(
                            child: Text('No matching campaigns found.'));
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredCampaigns.length,
                        itemBuilder: (context, index) {
                          final campaign = filteredCampaigns[index];
                          return ReusableCard(
                            title: campaign.title,
                            description: campaign.description,
                            category: campaign.category,
                            targetAmount: campaign.targetAmount,
                            donatedAmount: campaign.donatedAmount,
                            onTap: () {
                              // Handle card tap
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CampaignDetailsScreen(campaign: campaign),
                                ),
                              );
                            },
                          );
                        },
                      );
                    })
              ]),
        ),
      ),
    );
  }
}
