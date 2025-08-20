import 'package:donation_tracker/models/ngo_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/appuser.dart';

class FirebaseAuthMethods extends ChangeNotifier {
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
        await sendEmailVerification(context);
      } else {
        Fluttertoast.showToast(msg: "Login successful!");
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email. Please sign up";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Wrong password provided. Please try again.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "The email address is not valid.";
      } else {
        errorMessage = "An error occurred: ${e.message ?? 'Unknown error.'}";
      }

      Fluttertoast.showToast(msg: errorMessage);
    }
  }

  
  Future<NGO?> getNGOById(String ngoId) async {
    try {
      final docSnapshot = await _firestore.collection('ngos').doc(ngoId).get();
      if (docSnapshot.exists) {
        return NGO.fromMap(docSnapshot.data()!);
      }
      return null;
    } catch (e) {
      print('Error fetching NGO: $e');
      return null;
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

  

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      // After signing out, navigate to the login/landing screen

      Fluttertoast.showToast(msg: "Signed out successfully!");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message ?? 'An error occurred during signout');
    }
  }


Stream<Appuser?> getUserDetails(String uid) {
  // Listen to the document in real-time using snapshots()
  return _firestore.collection('users').doc(uid).snapshots().map((snapshot) {
    if (snapshot.exists) {
      // Transform the DocumentSnapshot into an Appuser object
      return Appuser.fromMap(snapshot.data()!);
    }
    // If the document doesn't exist, return null
    return null;
  });
}
}