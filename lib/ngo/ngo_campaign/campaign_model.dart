import 'package:cloud_firestore/cloud_firestore.dart';

class NgoCampaignModel {
  String id;
  String title;
  String description;
  String ngoName;
  String ngoId;
  String category;
  double targetAmount;
  double donatedAmount;
  // String imageUrl;
  Timestamp createdAt;

  NgoCampaignModel({
    required this.id,
    required this.title,
    required this.description,
    required this.ngoName,
    required this.ngoId,
    required this.category,
    required this.targetAmount,
    required this.donatedAmount,
    // required this.imageUrl,
    required this.createdAt,
  });

  factory  NgoCampaignModel.fromMap(Map<String, dynamic> map, String id){
    return NgoCampaignModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      ngoName: map['ngoName'] ?? '',
      ngoId: map['ngoId'] ?? '',
      category: map['category'] ?? '',
      targetAmount: map['targetAmount'] ?? 0,
      donatedAmount: map['donatedAmount'] ?? 0,
      // imageUrl: map['imageUrl'] ?? '',
      createdAt: map['createdAt'] as Timestamp,
    );
  }
}
