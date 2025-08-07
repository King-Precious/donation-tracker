
class Appuser {
  final String name;
  final String email;
  final String uid;
  final String role;



const Appuser({
    required this.name,
    required this.email,
    required this.uid,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'role': role,
    };
  }

  factory Appuser.fromMap(Map<String, dynamic> map) {
    return Appuser(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      role: map['role'] ?? '',
    );
  }
}