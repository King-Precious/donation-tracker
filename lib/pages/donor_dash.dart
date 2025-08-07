// ignore_for_file: deprecated_member_use
import 'package:donation_tracker/firebase/authentication/data/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:donation_tracker/firebase/appuser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../theme/theme_colors.dart';

class DonorDashboard extends StatelessWidget {
  const DonorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    final authMethods =
        Provider.of<FirebaseAuthMethods>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<Appuser?>(
          future: authMethods.getUserDetails(firebaseUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError || !snapshot.hasData ||snapshot.data == null) {
              return const Center(child: Text('Could not load user data.'));
            }

            final appUser = snapshot.data!;
            final userName = appUser.name.split(' ')[0];

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  'Welcome Back, $userName!',
                  style: const TextStyle(
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
                ),
              ],
            );
          },
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
