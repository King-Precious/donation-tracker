import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_tracker/models/appuser.dart';
import 'package:donation_tracker/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donation_tracker/pages/signup_page.dart';
import 'package:donation_tracker/widget/bottom_navigation.dart';
import 'donor/donate_history/donation_history.dart';
import 'firebase/authentication/firebase_auth_methods.dart';
import 'pages/emailverificationpage.dart';

class DonationApp extends StatelessWidget {
  const DonationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FirebaseAuthMethods(
            FirebaseAuth.instance,
            FirebaseFirestore.instance,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/signup_page': (context) => const SignupPage(),
          '/donation_history': (context) => const DonationHistory(),
          '/login_page': (context) => const LoginPage(),
        },
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authMethods = context.watch<FirebaseAuthMethods>();

    if (authMethods.user == null) {
      return const LoginPage();
    }

    if (!authMethods.user!.emailVerified) {
      // If the user is logged in but email is not verified, show the EmailVerificationPage
      return const EmailVerificationPage();
    }

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      
      final user = snapshot.data;


        // If no user is logged in, show the Login page
        if (user == null) {
          return const LoginPage();
        }

        // If a user is logged in but the email is not verified, show the verification page
        if (!user.emailVerified) {
          return const EmailVerificationPage();
        }

        // If the user is logged in and verified, get their role from Firestore
        return FutureBuilder<Appuser?>(
          future: Provider.of<FirebaseAuthMethods>(context, listen: false).getUserDetails(user.uid),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (userSnapshot.hasError || !userSnapshot.hasData || userSnapshot.data == null) {
              // Log the user out if their data is not found
              Provider.of<FirebaseAuthMethods>(context, listen: false).signOut(context);
              return const LoginPage();
            }
            
            final userRole = userSnapshot.data!.role;

            // Route to the appropriate dashboard based on the user's role
            if (userRole == 'donor') {
              return const BottomNavigationScreen(userRole: 'donor',);
            } else if (userRole == 'ngo') {
              return const BottomNavigationScreen(userRole: 'ngo');
            } else {
              // Log the user out if the role is unknown or invalid
              Provider.of<FirebaseAuthMethods>(context, listen: false).signOut(context);
              return const LoginPage();
            }
          },
        );
      },
    );
  }
}