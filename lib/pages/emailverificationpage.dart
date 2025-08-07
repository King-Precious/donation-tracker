import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../firebase/authentication/data/firebase_auth_methods.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuthMethods = Provider.of<FirebaseAuthMethods>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.email,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              const Text(
                'Verify Your Email Address',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'A verification link has been sent to your email. Please click the link to verify your account.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  // This will refresh the user token and trigger the AuthWrapper
                  // to re-evaluate the emailVerified status.
                  await firebaseAuthMethods.user?.reload();
                },
                child: const Text('I have verified my email'),
              ),
              TextButton(
                onPressed: () async {
                  // Allow the user to resend the verification email
                  await firebaseAuthMethods.sendEmailVerification(context);
                },
                child: const Text('Resend Verification Email'),
              ),
              TextButton(
                onPressed: () async {
                  // Log the user out and return to the login screen
                  await firebaseAuthMethods.signOut();
                },
                child: const Text('Log Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}