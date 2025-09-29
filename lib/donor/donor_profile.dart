import 'package:donation_tracker/pages/login_page.dart' show LoginPage;
import 'package:donation_tracker/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// REMOVED: import '../models/appuser.dart';
import '../firebase/authentication/firebase_auth_methods.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // The _signOut logic remains, as we still need a way to log a user out
  // if they happen to be logged in when viewing this page.
  Future<void> _signOut() async {
    // Check if a user is currently signed in before trying to sign them out
    if (FirebaseAuth.instance.currentUser != null) {
      final authMethods = Provider.of<FirebaseAuthMethods>(context, listen: false);
      await authMethods.signOut(context);
    }
    
    // Navigate to the login page and remove all other routes
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // REMOVED: final firebaseUser = FirebaseAuth.instance.currentUser;
    // REMOVED: final authMethods = Provider.of<FirebaseAuthMethods>(context, listen: false);

    // Determines if the Logout button should be visible.
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    return Scaffold(
      // The StreamBuilder is completely removed.
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Use a generic card since user data is removed.
              _buildGenericAppCard(), 
              const SizedBox(height: 20),
              _buildMenuSection(
                'Account Settings',
                [
                  _ProfileMenuItem(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () {
                      // Action for Change Password
                    },
                  ),
                  _ProfileMenuItem(
                    icon: Icons.notifications_active_outlined,
                    title: 'Notification Settings',
                    onTap: () {
                      // Action for Notification Settings
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildMenuSection(
                'General',
                [
                  _ProfileMenuItem(
                    icon: Icons.shield_outlined,
                    title: 'Privacy Policy',
                    onTap: () {
                      // Action for Privacy Policy
                    },
                  ),
                  _ProfileMenuItem(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () {
                      // Action for Help & Support
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Only show the Logout button if a user is logged in
              if (isLoggedIn) 
                CustomButton(
                  text: 'Logout',
                  onPressed: _signOut,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. Modified Helper Widget: _buildProfileCard -> _buildGenericAppCard

// We can no longer use Appuser, so we create a new generic widget.
Widget _buildGenericAppCard() {
  return Container(
    height: 260,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Colors.grey.withOpacity(0.2),
        width: 1.0,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            // You can keep the image asset or change it to an app logo/icon
            backgroundImage: AssetImage(
              'lib/assets/images/IMG-20250116-WA0053.jpg', 
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Precious O.King', // Generic App Name
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'kingprecious068@gmail.com ', // App Version
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 40,
            width: 80, // Widened container for better text fit
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 131, 13, 13).withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                'Donor', // Generic Status
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          )
        ],
      ),
    ),
  );
}

// The other helper widgets remain the same
Widget _buildMenuSection(String title, List<Widget> items) {
  // ... (Code remains the same)
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Colors.grey.withOpacity(0.2),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        ...items.map((item) => item),
      ],
    ),
  );
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ... (Code remains the same)
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                Icon(icon, color: Colors.grey[700]),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}