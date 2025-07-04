import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';
import '../widget/history_card.dart';

class DonationHistory extends StatelessWidget {
  const DonationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Themes.borderColor.withOpacity(0.2),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Total Donations Made',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '\$1850.75',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Themes.secondaryColor,
                      ),
                    ),
                    Text(
                      'Across 15 campaigns',
                      style: TextStyle(
                        fontSize: 12,
                        color: Themes.borderColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 17),
              const Text(
                'Recent Transactions',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              const HistoryCard(
                title: 'Supporting Local Farmers',
                date: 'November 20, 2023',
                description: 'Confirmed',
              ),
              const HistoryCard(
                title: 'Clean Water Initiative',
                date: 'October 21, 2023',
                description: 'Confirmed',
              ),
              const HistoryCard(
                title: 'Emergency Flood Relief',
                date: 'November 15, 2023',
                description: 'Confirmed',
              ),
              const HistoryCard(
                title: 'Wildlife Conservation',
                date: 'November 2, 2023',
                description: 'Confirmed',
              ),
              const HistoryCard(
                title: 'Global Health Aid',
                date: 'September 15, 2023',
                description: 'Confirmed',
              ),
              const HistoryCard(
                title: 'Animal Shelter Support',
                date: 'November 02, 2023',
                description: 'Confirmed',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
