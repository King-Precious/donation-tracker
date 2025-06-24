import 'package:donation_tracker/widget/custom_button.dart';
import 'package:donation_tracker/widget/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Email Address',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const CustomTextfield(
              labeltext: 'Email Address',
              hinttext: 'Enter your Email Address',
            ),
            const Text(
              'Password',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const CustomTextfield(
              labeltext: 'Passworrd',
              hinttext: '******',
            ),
            const Text(
              'Select Your Role',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          Custombutton(text: 'Log in',onPressed: (){}),
            RichText(
              text: const TextSpan(
                  text: 'Don\'t have an account yet?',
                  style: TextStyle(
                    color: Themes.borderColor,
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        color: Themes.secondaryColor,
                        fontSize: 15,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
