import 'package:donation_tracker/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:donation_tracker/pages/signup_page.dart';
import 'package:donation_tracker/pages/donor_dashboard.dart';
import 'package:donation_tracker/pages/ngo_dashboard.dart';
import 'pages/donation_history.dart';

class DonationApp extends StatelessWidget {
  const DonationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/signup_page',
      routes: {
        '/signup_page': (context) => const SignupPage(),
        '/donorDashboard': (context) => const DonorDashboard(),
        '/ngoDashboard': (context) => const NgoDashboard(),
        '/donation_history': (context) => const DonationHistory(),
        '/login_page': (context) => const LoginPage(),
      },
    );
  }
}
