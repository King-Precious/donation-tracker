import 'package:flutter/material.dart';
import 'package:donation_tracker/widget/custom_button.dart';


class CampaignDetails extends StatelessWidget {
  const CampaignDetails({super.key});

 @override
  Widget build (BuildContext context){
    return Scaffold(
            appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          'Campaign Details',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Campaign Title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Campaign description goes here. This is a detailed description of the campaign, its goals, and how it aims to make a difference.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Donate',
              onPressed: (){},
              )
          ],
        ),
      ),
    );
  }
}