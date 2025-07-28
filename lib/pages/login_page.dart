import 'package:donation_tracker/widget/custom_button.dart';
import 'package:donation_tracker/widget/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:donation_tracker/utils/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import '../theme/theme_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final formkey = GlobalKey<FormState>();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();


 void LoginUser() {
  FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
    email: emailController.text.trim(),
    password: passwordController.text.trim(),
  );
 }
 


class _LoginPageState extends State<LoginPage> {
  String selectedRole = '';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
          child: Form(
            key: formkey,
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
                  padding: EdgeInsets.all(10),
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
                CustomTextfield(
                  labeltext: 'Email Address',
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    } else if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 92, 91, 91),
                  ),
                ),
                CustomTextfield(
                    labeltext: 'Password',
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 8 &&
                          !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$')
                              .hasMatch(value)) {
                        return '''Password must be at least 8 characters long,
contain at least one uppercase letter.''';
                      }
                      return null;
                    }),
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
                CustomButton(
                    text: 'Log in',
                    onPressed: () {
                      if (formkey.currentState!.validate() &&
                          (selectedRole == 'Donor' || selectedRole == 'NGO')) {
                            LoginUser();
                        Navigator.pushNamed(context, '/donorDashboard');
                        // Perform login action
                        // For example, you can call an API to authenticate the user
                        // If successful, navigate to the dashboard
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login Successful')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill all fields')),
                        );
                      }
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
        ),
      ),
    );
  }
}
