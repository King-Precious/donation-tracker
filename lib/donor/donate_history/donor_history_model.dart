
// File: lib/models/campaign.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  final String id;
  final String campaignTitle;
  final String campaignId;
  final String ngoId;
  final String subtitle;
  final int amount;
  final Timestamp donationDate;

  Donation ({
    required this.id,
    required this.campaignTitle,
    required this.campaignId,
    required this.ngoId,
    required this.subtitle,
    required this.amount,
    required this.donationDate,
  });

  factory Donation.fromMap(Map<String, dynamic> map, String id) {
    return Donation(
      id: id,
      campaignId: map['campaignId'] ?? '',
      campaignTitle: map['campaignTitle'] ?? '',
      ngoId: map['donorId'] ?? '',
      subtitle: map['subtitle'] ?? '',
      amount: map['amount'] ?? 0,
      donationDate: map['donationDate'] as Timestamp,
    );
  }
}