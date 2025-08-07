import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../appuser.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  FirebaseAuthMethods(this._auth, this._firestore);

  User? get user => _auth.currentUser;

// EMAIL SIGN UP METHOD
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required String role,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final appUser = Appuser(
        name: name,
        email: email,
        uid: userCredential.user!.uid,
        role: role, // Default role, can be changed later
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set(
            appUser.toMap(), // Use the toMap() method from our Appuser model
          );

      await sendEmailVerification(context);
      Fluttertoast.showToast(msg: "Account created successfully!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.");
      } else {
        Fluttertoast.showToast(msg: "An error occurred: ${e.message}");
      }
    }
  }

// EMAIL LOGIN METHOD
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (_auth.currentUser != null && !_auth.currentUser!.emailVerified) {
        Fluttertoast.showToast(
            msg: "Please verify your email before logging in.");
        await sendEmailVerification(context);
      } else {
        Fluttertoast.showToast(msg: "Login successful!");
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "An error occurred: ${e.message}");
    }
  }

  //  EMAIL VERIFICATION METHOD
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      Fluttertoast.showToast(
          msg: "Verification email sent. Please check your inbox.");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to send verification email: ${e.message}");
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Fluttertoast.showToast(msg: "Logged out successfully.");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "Failed to log out: ${e.message}");
    }
  }


Future<Appuser?> getUserDetails(String uid) async {
  try {
    final docSnapshot = await _firestore.collection('users').doc(uid).get();
    if (docSnapshot.exists) {
      return Appuser.fromMap(docSnapshot.data()!);
    }
    return null;
  } catch (e) {
    Fluttertoast.showToast(msg: "Error fetching user data: ${e.toString()}");
    return null;
  }
}
}