import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<String?> createUserWithEmailAndPassword(
    String email,
    String password,
    String fullName,
    String phone,
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;
      if (user == null) return "Signup failed.";

      await _firestore.collection("Users").doc(user.uid).set({
        "uid": user.uid,
        "email": email,
        "fullName": fullName,
        "phoneNo": phone,
      });

      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException during signup: Code: ${e.code}, Message: ${e.message}");
      return e.message;
    } catch (e, stacktrace) {
      debugPrint("Unexpected error during signup: $e");
      debugPrint("$stacktrace");
      return "An unexpected error occurred.";
    }
  }

  Future<String?> loginWithEmailAndPassword(String email, String password) async {
  try {
    print("Attempting login for $email");
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    print("Login success");
    return null;
  } on FirebaseAuthException catch (e) {
    print("FirebaseAuthException during login: ${e.code} - ${e.message}");
    return e.message;
  } catch (e, stacktrace) {
    print("Unexpected error during login: $e");
    print(stacktrace);
    return "An unexpected error occurred.";
  }
}



  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException during password reset: Code: ${e.code}, Message: ${e.message}");
      return e.message ?? "Failed to send reset email.";
    } catch (e, stacktrace) {
      debugPrint("Unexpected error during password reset: $e");
      debugPrint("$stacktrace");
      return "An unexpected error occurred.";
    }
  }

  Future<String?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return "Google sign-in was cancelled.";

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the Google credential
    final result = await _auth.signInWithCredential(credential);
    final user = result.user;

    if (user == null) return "Google sign-in failed.";

    final userDoc = _firestore.collection("Users").doc(user.uid);
    final userSnapshot = await userDoc.get();

    if (!userSnapshot.exists) {
      await userDoc.set({
        "uid": user.uid,
        "email": user.email,
        "fullName": user.displayName ?? '',
        "phoneNo": user.phoneNumber ?? '',
      });
    }

    return null;
  } on FirebaseAuthException catch (e) {
    print("🔥 FirebaseAuthException: ${e.code} - ${e.message}");
    return e.message ?? "An unexpected Firebase error occurred.";
  } catch (e, stack) {
    print("🔥 Exception during Google Sign-In: $e");
    print(stack);
    return "An unexpected error occurred.";
  }
}

  Future<void> logout() async => await _auth.signOut();

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;
}
