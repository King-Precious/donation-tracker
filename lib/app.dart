import 'package:donation_tracker/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donation_tracker/pages/signup/signup_page.dart';
import 'package:donation_tracker/widget/bottom_navigation.dart';
import 'package:donation_tracker/pages/ngo_dashboard.dart';
import 'pages/donation_history.dart';
import 'utils/firebase_auth_methods.dart';

class DonationApp extends StatelessWidget {
  const DonationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider<User?>(
          create: (context) => FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/signup_page',
        routes: {
          '/signup_page': (context) => const SignupPage(),
          '/donorDashboard': (context) => const BottomNavigationScreen(),
          '/ngoDashboard': (context) => const NgoDashboard(),
          '/donation_history': (context) => const DonationHistory(),
          '/login_page': (context) => const LoginPage(),
        },
      ),
    );
  }
}
