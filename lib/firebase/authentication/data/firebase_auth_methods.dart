import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);
  

// EMAIL SIGN UP METHOD
  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async{
    try {
     await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await sendEmailVerification();
     } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(msg: "The password provided is too weak.");
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(msg: "The account already exists for that email.");
        } else {
          Fluttertoast.showToast(msg: "An error occurred: ${e.message}");
        }
      }
  }

// EMAIL LOGIN METHOD
   Future<void> loginWithEmail({
    required String email,
    required String password,
   }) async{
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (_auth.currentUser != null && !_auth.currentUser!.emailVerified) {
      Fluttertoast.showToast(msg: "Please verify your email before logging in.");
      await sendEmailVerification();
    } else {
      Fluttertoast.showToast(msg: "Login successful!");
    }
   }
   
  //  EMAIL VERIFICATION METHOD
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      Fluttertoast.showToast(msg: "Verification email sent. Please check your inbox.");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "Failed to send verification email: ${e.message}");
    }
  }
}