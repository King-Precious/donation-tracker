import 'package:donation_tracker/donor/campaigns/camp_model.dart' show Campaign;
import 'package:flutter/material.dart';
import 'package:donation_tracker/widget/custom_button.dart';
import '../../theme/theme_colors.dart';

class CampaignDetailsScreen extends StatelessWidget {
  final Campaign campaign;

  const CampaignDetailsScreen({
    super.key,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          'Campaign Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              campaign.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'By: ${campaign.ngoName}',
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              campaign.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Progress:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: campaign.donatedAmount / campaign.targetAmount,
              backgroundColor: Themes.borderColor,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Themes.secondaryColor),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${campaign.donatedAmount} raised of \$${campaign.targetAmount} target',
              style: const TextStyle(fontSize: 16),
            ),
            CustomButton(
              text: 'Donate Now',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
