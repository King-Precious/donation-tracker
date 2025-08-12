import 'package:flutter/material.dart';

class NgoProfileScreen extends StatelessWidget {
  const NgoProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NGO Profile'),
      ),
      body: const Center(
        child: Text('NGO-specific profile content will go here.'),
      ),
    );
  }
}