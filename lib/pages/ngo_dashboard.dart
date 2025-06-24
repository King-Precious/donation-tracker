import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

class NgoDashboard extends StatelessWidget {
  const NgoDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
backgroundColor: Themes.secondaryColor,
        title: const Text(
          'Admin Panel',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Themes.primaryColor,
          ),
        ),
      ),
      body: const Column(
       children: [
        Text('Welcome to Donor Dashboard'),
        Text('Create new Campaign'),
        Text('View Total donations received'),
        Text('Withdwraw Funds'),
        
       ],
      ),
    );
  }
}
