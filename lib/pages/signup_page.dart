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
  List <String> roles = [
    'Donor',
    'NGO/Organisation',
  ];
  String? selectedRole;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
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
                hinttext: 'Enter your Name',
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
                hinttext: 'Enter your email',
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
                labeltext: 'Password',
                hinttext: '*****',
              ),
              const SizedBox(height: 20),
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
                    Container(
                      height: 80,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Themes.secondaryColor,
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              Icon(
                                Icons.handshake_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                'Donor',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      height: 80,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Themes.secondaryColor),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.hotel_class_rounded,
                                color: Colors.white,
                              ),
                              Text(
                                'NGO/Organisation',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Custombutton(
                text:'Create Account',
                onPressed: (){},
              ),
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
