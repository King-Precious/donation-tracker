import 'package:donation_tracker/widget/campaign_card.dart';
import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';
// import '../widget/custom_button.dart';

class DonorDashboard extends StatelessWidget {
  const DonorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Themes.secondaryColor,
        title: const Text(
          'Donor Dashboard',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Themes.primaryColor,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Campaigns',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Themes.primaryColor,
                  ),
                ),
                SizedBox(height: 20),
                CampaignCard(
                  amountRaised: '\$5000',
                  campaignname: 'Education Fund',
                ),
                SizedBox(height: 20),
                CampaignCard(
                  amountRaised: '\$4500',
                  campaignname: 'Health Initiative',
                ),
                SizedBox(height: 20),
                CampaignCard(
                  amountRaised: '\$2500',
                  campaignname: 'Hunger Relief',
                ),
                SizedBox(height: 20),
                CampaignCard(
                  amountRaised: '\$7000',
                  campaignname: 'Disaster Relief',
                ),
                SizedBox(height: 50),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
