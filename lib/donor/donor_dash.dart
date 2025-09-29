// ignore_for_file: deprecated_member_use
// import 'package:donation_tracker/donor/donate_history/history_card.dart';
import 'package:donation_tracker/firebase/authentication/firebase_auth_methods.dart';
import 'package:donation_tracker/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:donation_tracker/models/appuser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
// import '../theme/theme_colors.dart';

class DonorDashboard extends StatefulWidget {
  const DonorDashboard({super.key});

  @override
  State<DonorDashboard> createState() => _DonorDashboardState();
}

class _DonorDashboardState extends State<DonorDashboard> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    final authMethods =
        Provider.of<FirebaseAuthMethods>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      child: Scaffold(
        backgroundColor: Colors.white,
        // body: StreamBuilder<Appuser?>(
        //   // stream: authMethods.getUserDetails(firebaseUser!.uid),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //     if (snapshot.hasError ||
        //         !snapshot.hasData ||
        //         snapshot.data == null) {
        //       return const Center(child: Text('Could not load user data.'));
        //     }

        //     final appUser = snapshot.data!;
        //     final userName = appUser.name.split(' ')[0];

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      AssetImage('assets/images/IMG-20250116-WA0053.jpg'),
                ),
                SizedBox(width: 15),
                Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good day,!',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                Spacer(),
                Icon(
                  Icons.notifications_none_outlined,
                  // color: Themes.primaryColor,
                  size: 25,
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomTextfield(
              controller: _searchController,
              icon: const Icon(Icons.search),
              labeltext: 'Search',
            ),
            const SizedBox(height: 20),
            const Text(
              'You can manage your donations and view your donation history.',
              style: TextStyle(fontSize: 13),
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
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _imageCard('lib/assets/images/scholarship.png', 'Scholarship'),
                _imageCard('lib/assets/images/heartbeat.png', 'Medical Aid'),
                _imageCard('lib/assets/images/faucet.png', 'Water Relief'),
                _imageCard('lib/assets/images/heartbeat.png', 'Animal health'),
              ],
            ),
            const SizedBox(height: 20),
            Container(child: Image.asset('lib/assets/images/charity.png')),
            // Row(
            //   children: [
            //     const Text(
            //       'Donation History',
            //       style: TextStyle(
            //         fontSize: 15,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     const Spacer(),
            //     TextButton(
            //       onPressed: () {},
            //       child: const Text(
            //         'View All',
            //         style: TextStyle(
            //           color: Colors.blue,
            //           fontSize: 16,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationCard(String title, String subtitle) {
    return Expanded(
      child: Card(
        color: Colors.blueGrey[35],
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

  Widget _imageCard(String imagePath, String title) {
    return Container(
      decoration: BoxDecoration(
        // color: Themes.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 40,
              width: 40,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
