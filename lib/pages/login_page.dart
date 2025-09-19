import 'package:donation_tracker/widget/custom_button.dart';
import 'package:donation_tracker/widget/custom_textfield.dart';
import 'package:donation_tracker/firebase/authentication/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  

final formkey = GlobalKey<FormState>();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

 
// This is the function that will call our login method
  void _loginUser() async{
    // Check if the form fields are valid
    if (formkey.currentState!.validate()) {
      // Step 1: Use Provider to get our service class instance
      // listen: false is used because we're just calling a method.
     await Provider.of<FirebaseAuthMethods>(context, listen: false).loginWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        context: context,// Pass the context for error handling
      );
    }
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
        // leading: IconButton(
        //   onPressed: Navigator.of(context).pop,
        //   icon: const Icon(Icons.arrow_back_ios),
        // ),
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
                      }
                        return null;
                      }
                ),
                const SizedBox(height: 20),

                
                CustomButton(
                    text: 'Log in',
                    onPressed: _loginUser,
                    ),
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
      )
    );
  }
}
