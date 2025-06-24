import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

class DonationHistory extends StatelessWidget {
  const DonationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Themes.secondaryColor,
        title: const Text(
          'Donation History',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Themes.primaryColor,
          ),
        ),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
