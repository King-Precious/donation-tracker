import 'package:donation_tracker/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donation_tracker/firebase/authentication/firebase_auth_methods.dart';
import 'package:donation_tracker/models/ngo_model.dart'; 


class NgoProfileSetupScreen extends StatefulWidget {
  const NgoProfileSetupScreen({super.key});

  @override
  State<NgoProfileSetupScreen> createState() => _NgoProfileSetupScreenState();
}

class _NgoProfileSetupScreenState extends State<NgoProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _ngoName = '';
  String _ngoMission = '';
  String _ngoRegistrationNumber = '';
  bool _isLoading = false;

  Future<void> _submitProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      final authMethods = Provider.of<FirebaseAuthMethods>(context, listen: false);
      final user = authMethods.user;

      if (user == null) {
        // Handle case where user is not authenticated
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not authenticated')),
        );
        return;
      }

      final ngoProfile = NGO(
        uid: user.uid,
        name: _ngoName,
        mission: _ngoMission,
        registrationNumber: _ngoRegistrationNumber,
      );
      
      try {
        await authMethods.saveNgoProfile(ngoProfile);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const BottomNavigationScreen(userRole: 'ngo'),
          ),
        );
      } catch (e) {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save profile: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        automaticallyImplyLeading: false, // Prevent the user from going back
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'NGO Name'),
                      validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
                      onSaved: (value) => _ngoName = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Mission Statement'),
                      validator: (value) => value!.isEmpty ? 'Please enter a mission' : null,
                      onSaved: (value) => _ngoMission = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Registration Number'),
                      validator: (value) => value!.isEmpty ? 'Please enter a registration number' : null,
                      onSaved: (value) => _ngoRegistrationNumber = value!,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitProfile,
                      child: const Text('Save Profile'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}