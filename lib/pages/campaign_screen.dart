import 'package:flutter/material.dart';
import 'package:donation_tracker/widget/reuseable_card.dart';

// import '../theme/theme_colors.dart';
import '../widget/custom_textfield.dart';

class CampaignScreen extends StatelessWidget {
  const CampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: const Text(
      //     'Campaigns',
      //     style: TextStyle(
      //       fontSize: 24,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 25),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            CustomTextfield(
              icon: Icon(Icons.search),
              labeltext: 'Search Campaigns...',
            ),
            ReusableCard(
              title: 'Clean Water Project',
              subtitle: 'Providing safe and clean drinking water',
              type: 'environment',
            ),
            ReusableCard(
              title: 'Education For All',
              subtitle: 'Building schools and providing learning',
              type: 'emergency',
            ),
            ReusableCard(
              title: 'Medical Aid Campaign',
              subtitle: 'Delivering essential medical supplies',
              type: 'health',
            ),
            ReusableCard(
              title: 'Sustainable Farming Initiative',
              subtitle: 'Empowering local farmers with resources',
              type: 'environment',
            ),
            ReusableCard(
              title: 'Emergency Relief Fund',
              subtitle: 'DIsaster response and recovery',
              type: 'emergency',
            ),
          ]),
        ),
      ),
    );
  }
}
