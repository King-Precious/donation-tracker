import 'package:donation_tracker/ngo/ngo_profile/ngo_create_profile.dart';
import 'package:donation_tracker/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donation_tracker/firebase/authentication/firebase_auth_methods.dart';
import 'package:donation_tracker/models/ngo_model.dart';

import '../../pages/login_page.dart';

class NgoProfileScreen extends StatefulWidget {
  const NgoProfileScreen({super.key});

  @override
  State<NgoProfileScreen> createState() => _NgoProfileScreenState();
}

class _NgoProfileScreenState extends State<NgoProfileScreen> {
  Future<void> _signOut() async {
    final authMethods =
        Provider.of<FirebaseAuthMethods>(context, listen: false);
    await authMethods.signOut(context);

    // Navigate to the login page and remove all other routes
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  NGO? _ngo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNgoProfile();
  }

  Future<void> _fetchNgoProfile() async {
    final authMethods =
        Provider.of<FirebaseAuthMethods>(context, listen: false);
    final user = authMethods.user;

    if (user != null) {
      final fetchedNgo = await authMethods.getNGOById(user.uid);
      setState(() {
        _ngo = fetchedNgo;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      // Handle the case where the user is not logged in.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _ngo != null
              ? _buildProfileDetails()
              : Center(
                  child: Column(
                    children: [
                      const Text(
                          'No profile found. Please complete your profile setup.'),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Complete Profile',
                        onPressed: () {
                          // Navigate to a screen where the user can create their NGO profile
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const NgoProfileSetupScreen(), // You will need to create this screen
                            ),
                          ).then((_){
                            // Refresh the profile after returning from the setup screen
                            _fetchNgoProfile();
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'Logout',
                        onPressed: _signOut, // Still allow logout
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildProfileDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'NGO Details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildInfoRow('Name:', _ngo!.name),
          _buildInfoRow('Mission:', _ngo!.mission),
          _buildInfoRow('Registration No.:', _ngo!.registrationNumber),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Logout',
            onPressed: _signOut,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
