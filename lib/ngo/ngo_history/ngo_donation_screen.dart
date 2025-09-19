import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_tracker/theme/theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'ngo_history_model.dart';

class NgoDonationHistoryScreen extends StatelessWidget {
  const NgoDonationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ngoId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
     
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('donations')
            .where('ngoId', isEqualTo: ngoId) // Assuming 'ngoId' is stored in the donation doc
            .orderBy('donationDate', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No donations received yet.'));
          }

          final donations = snapshot.data!.docs.map((doc) {
            return Donation.fromMap(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();

          return ListView.builder(
            itemCount: donations.length,
            itemBuilder: (context, index) {
              final donation = donations[index];
              final formattedDate = DateFormat('MMMM dd, yyyy').format(donation.donationDate.toDate());

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: const Icon(Icons.favorite, color: Themes.secondaryColor),
                  title: Text(donation.campaignTitle),
                  subtitle: Text('Donated on $formattedDate'),
                  trailing: Text(
                    '\$${donation.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Themes.primaryColor,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}