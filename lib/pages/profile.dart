import 'package:donation_tracker/widget/custom_button.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Profile',
      //     style: TextStyle(
      //       fontSize: 24,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                        backgroundImage: AssetImage(
                          'lib/assets/images/IMG-20250116-WA0053.jpg',
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Precious King',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'kingprecious068@gmail.com',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 131, 13, 13)
                              .withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text('Donor',
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
              ),
              const SizedBox(height: 20),
              _buildPassword(
                'Account Settings',
                Icon(Icons.lock_outline),
                'Change Password',
                Icon(Icons.notifications_active_outlined),
                'Notification Settings',
              ),
              const SizedBox(height: 20),
              _buildPassword(
                'General',
                Icon(Icons.shield_outlined),
                'Privacy Policy',
                Icon(Icons.help_outline),
                'Help & Support',
              ),
              const SizedBox(height: 20),
              Custombutton(text: 'Logout', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildPassword(
  String title,
  Icon icon,
  String title2,
  Icon icon2,
  String title3,
) {
  return Container(
    height: 160,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Colors.grey.withOpacity(0.2),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: icon,
            ),
            Text(
              title2,
              style: const TextStyle(fontSize: 15),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          ]),
          Divider(
            color: Colors.grey.withOpacity(0.2),
            thickness: 1,
          ),
          Row(children: [
            Padding(padding: EdgeInsets.all(8.0), child: icon2),
            Text(
              title3,
              style: const TextStyle(fontSize: 15),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          ]),
        ],
      ),
    ),
  );
}
