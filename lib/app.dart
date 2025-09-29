import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_tracker/donor/donate.dart';
// import 'package:donation_tracker/donor/donate.dart';
// import 'package:donation_tracker/models/appuser.dart';
// import 'package:donation_tracker/models/ngo_model.dart';
// import 'package:donation_tracker/ngo/ngo_profile/ngo_create_profile.dart';
import 'package:donation_tracker/pages/login_page.dart';
import 'package:donation_tracker/widget/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donation_tracker/pages/signup_page.dart';
// import 'package:donation_tracker/widget/bottom_navigation.dart';
import 'donor/donate_history/donation_history.dart';
import 'firebase/authentication/firebase_auth_methods.dart';
// import 'pages/emailverificationpage.dart';

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
          '/donate_screen': (context) => const DonationScreen(),

        },
        home: const BottomNavigationScreen(),
      ),
    );
  }
}

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final authMethods = context.watch<FirebaseAuthMethods>();

//     if (authMethods.user == null) {
//       return const LoginPage();
//     }

//     if (!authMethods.user!.emailVerified) {
//       return const EmailVerificationPage();
//     }

//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         final user = snapshot.data;

//         if (user == null) {
//           return const LoginPage();
//         }

//         if (!user.emailVerified) {
//           return const EmailVerificationPage();
//         }

//         return StreamBuilder<Appuser?>(
//           stream: Provider.of<FirebaseAuthMethods>(context, listen: false).getUserDetails(user.uid),
//           builder: (context, userSnapshot) {
//             // Check the connection state of the Firestore stream
//             if (userSnapshot.connectionState == ConnectionState.waiting) {
//               return const Scaffold(
//                 body: Center(child: CircularProgressIndicator()),
//               );
//             }

//             // Now, check for errors or missing data AFTER waiting
//             if (userSnapshot.hasError || userSnapshot.data == null) {
//               // This indicates a critical issue.
//               // We could show an error, but logging out is a good fallback.
//               Provider.of<FirebaseAuthMethods>(context, listen: false).signOut(context);
//               return const LoginPage();
//             }

//             // Data is available.
//             final userRole = userSnapshot.data!.role;

//             // Route to the appropriate dashboard based on the user's role
//             if (userRole == 'donor') {
//               return const BottomNavigationScreen(userRole: 'donor',);
//             } else if (userRole == 'ngo') {
//               return const NgoProfileSetupScreen();
//             } else {
//               // Log the user out if the role is unknown or invalid
//               Provider.of<FirebaseAuthMethods>(context, listen: false).signOut(context);
//               return const LoginPage();
//             }
//           },
//         );
//       },
//     );
//   }
// }