// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

class DonorDashboard extends StatelessWidget {
  const DonorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome Back, Precious!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You can manage your donations and view your donation history.',
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDonationCard('Total Donated', '\$5000'),
                  _buildDonationCard('Last Donation', 'August 20, 2023'),
                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }
}

Widget _buildDonationCard(String title, String subtitle) {
  return Expanded(
    child: Card(
      color: Themes.borderColor.withOpacity(0.1),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
      ),
    ),
  );
}
