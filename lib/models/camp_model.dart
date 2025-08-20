
// File: lib/models/campaign.dart

class Campaign {
  final String id;
  final String title;
  final String description;
  final String ngoId;
  final String ngoName;
  final String category;
  // final String imageUrl;
  final int targetAmount;
  final int donatedAmount;

  Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.ngoId,
    required this.ngoName,
    required this.category,
    // required this.imageUrl,
    required this.targetAmount,
    required this.donatedAmount,
  });

  factory Campaign.fromMap(Map<String, dynamic> map, String id) {
    return Campaign(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      ngoId: map['ngoId'] ?? '',
      ngoName: map['ngoName'] ?? '',
      category: map['category'] ?? '',
      // imageUrl: map['imageUrl'] ?? '',
      targetAmount: map['targetAmount'] ?? 0,
      donatedAmount: map['donatedAmount'] ?? 0,
    );
  }
}