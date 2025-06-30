import 'package:donation_tracker/widget/custom_button.dart';
import 'package:donation_tracker/widget/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String selectedRole = 'Donor';

  Widget _buildRoleOption(String role, IconData icon) {
    return Container(
      height: 50,
      width: 350,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: selectedRole == role
              ? Themes.secondaryColor
              : Colors.grey.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              value: role,
              groupValue: selectedRole,
              onChanged: (value) {
                setState(() {
                  selectedRole = value!;
                });
              }),
          Icon(
            icon,
            color: Themes.primaryColor,
          ),
          Text(
            role,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Icon(Icons.assignment,
                    size: 40, color: Themes.secondaryColor),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Center(
                child: Text(
                  'Welcome Back !',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
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
            const SizedBox(height: 10),
            const Text(
              'Password',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 92, 91, 91),
              ),
            ),
            const CustomTextfield(
              labeltext: 'Password',
            ),
            const SizedBox(height: 10),
            const Text(
              'Select Your Role',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 92, 91, 91),
              ),
            ),
            Column(children: [
              _buildRoleOption(
                'Donor',
                Icons.person_2_outlined,
              ),
              const SizedBox(width: 10),
              _buildRoleOption(
                'NGO',
                Icons.shield_outlined,
              ),
            ]),
            const SizedBox(height: 20),
            Custombutton(
                text: 'Log in',
                onPressed: () {
                  Navigator.pushNamed(context, '/donorDashboard');
                }),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account yet?',
                  style: TextStyle(
                    color: Themes.borderColor,
                    fontSize: 15,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup_page');
                  },
                  child: const Text( 
                    'Sign Up',
                    style: TextStyle(
                      color: Themes.secondaryColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
