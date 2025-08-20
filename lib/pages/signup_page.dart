import 'package:donation_tracker/firebase/authentication/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import '../theme/theme_colors.dart';
import 'package:donation_tracker/widget/custom_button.dart';
import '../widget/custom_textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  int selectedIndex = -1;

  void selectedContainer(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final formkey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String get _selectedRole {
    if (selectedIndex == 0) {
      return 'donor';
    } else if (selectedIndex == 1) {
      return 'ngo';
    }
    return ''; // Return an empty string if nothing is selected
  }

  // This is the function that will call our Firebase authentication method
  void _signUpUser() {
    // We check if the form is valid and a role has been selected
    if (formkey.currentState!.validate() && selectedIndex != -1) {
      // Step 1: Use Provider to get our service class instance
      // We use listen: false because we only want to call a method, not listen for state changes.
      Provider.of<FirebaseAuthMethods>(context, listen: false).signUpWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: fullNameController.text.trim(),
        role: _selectedRole, // Pass the selected role as a string
        context: context,
      );
    } else {
      // Show an error if validation fails or role is not selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields correctly and select a role.'),
        ),
      );
    }
  }

  // Future<void> signUpWithEmail() async {
  //   FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
  //     email: emailController.text.trim(),
  //     password: passwordController.text.trim(),
  //   );
  // }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
            child: Form(
              key: formkey,
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
                  CustomTextfield(
                    labeltext: 'Full Name',
                    controller: fullNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return 'Please enter a valid name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
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
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
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
contain at least one uppercase letter,
one lowercase letter.''';
                        }
                        return null;
                      }),
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
                    child: CustomButton(
                      text: 'Create Account',
                      onPressed: _signUpUser, // Call the sign-up function
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,                    children: [
                      const Text(
                        '''By registering, you agree to our Terms of 
Service and receive donations, ''',
                        style: TextStyle(
                          color: Themes.borderColor,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login_page');
                        },
                        child: const Text('Login In',
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
      ),
    );
  }
}
