import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthState extends ChangeNotifier {
  final FirebaseAuth _auth;

  AuthState(this._auth);

  // A stream that listens for authentication state changes (login/logout)
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}