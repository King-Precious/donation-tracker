import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  int selectedIndex = 0;

  void selectedContainer(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                  child: Icon(Icons.assignment,
                      size: 40, color: Themes.secondaryColor)),
              const Center(
                child: Text(
                  'Join DonateSmart',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Themes.primaryColor,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  '''Sign up to start your journey of giving or 
                          receiving.''',
                  style: TextStyle(
                    fontSize: 15,
                    color: Themes.borderColor,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Personal Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 92, 91, 91),
                ),
              ),
              const CustomTextfield(
                labeltext: 'Full Name',
              ),
              const SizedBox(height: 15),
              const Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 92, 91, 91),
                ),
              ),
              const CustomTextfield(
                labeltext: 'Email Address',
              ),
              const SizedBox(height: 15),
              const Text(
                ' Password',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 92, 91, 91),
                ),
              ),
              const CustomTextfield(
                labeltext:'Password',
              ),
              const SizedBox(height: 10),
              const Text('I am a...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => selectedContainer(0),
                      child: Container(
                        height: 80,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: selectedIndex == 0
                              ? Themes.secondaryColor
                              : Colors.white,
                          border: Border.all(
                            color: selectedIndex == 0
                                ? Colors.transparent
                                : Themes.borderColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.handshake_outlined,
                                  color: selectedIndex == 0
                                      ? Colors.white
                                      : Themes.borderColor,
                                ),
                                Text(
                                  'Donor',
                                  style: TextStyle(
                                    color: selectedIndex == 0
                                        ? Colors.white
                                        : Themes.borderColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    GestureDetector(
                      onTap: () => selectedContainer(1),
                      child: Container(
                        height: 80,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: selectedIndex == 1
                              ? Themes.secondaryColor
                              : Colors.white,
                          border: Border.all(
                            color: selectedIndex == 1
                                ? Colors.transparent
                                : Themes.borderColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.hotel_class_rounded,
                                  color: selectedIndex == 1
                                      ? Colors.white
                                      : Themes.borderColor,
                                ),
                                Text(
                                  'NGO/Organisation',
                                  style: TextStyle(
                                    color: selectedIndex == 1
                                        ? Colors.white
                                        : Themes.borderColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: Custombutton(
                  text: 'Create Account',
                  onPressed: () {
                    Navigator.pushNamed(context, '/login_page');
                  },
                ),
              ),
              const SizedBox(height: 5),
              const Center(
                child: Text(
                  '''By registering, you agree to our Terms of Service 
                and receive donations.''',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
