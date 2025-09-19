class NGO {
  final String uid;
  final String name;
  final String mission;
  final String registrationNumber;

  NGO({
    required this.uid,
    required this.name,
    required this.mission,
    required this.registrationNumber,
  });

  // Factory constructor to create an NGO instance from a Firestore document
  factory NGO.fromMap(Map<String, dynamic> map) {
    return NGO(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      mission: map['mission'] ?? '',
      registrationNumber: map['registrationNumber'] ?? '',
    );
  }

  // Method to convert an NGO instance to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'mission': mission,
      'registrationNumber': registrationNumber,
    };
  }
}
