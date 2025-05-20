import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

/// A GetX controller that handles user authentication and Firestore operations.
class AuthenticationRepository extends GetxController {
  /// Singleton instance to access this controller from anywhere using `AuthenticationRepository.instance`
  static AuthenticationRepository get instance => Get.find();

  // Firebase authentication and Firestore instances
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  /// Registers a new user using email and password, and saves additional info to Firestore.
  ///
  /// Params:
  /// - [email]: User's email address
  /// - [password]: User's chosen password
  /// - [fullName]: User's full name
  /// - [phone]: User's phone number
  ///
  /// Returns:
  /// - null on success
  /// - Error message string on failure
  Future<String?> createUserWithEmailAndPassword(
    String email,
    String password,
    String fullName,
    String phone,
  ) async {
    try {
      // Create user using Firebase Auth
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;
      if (user == null) return "Signup failed.";

      // Store user details in Firestore
      await _firestore.collection("Users").doc(user.uid).set({
        "uid": user.uid,
        "email": email,
        "fullName": fullName,
        "phoneNo": phone,
      });

      return null; // Success
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      return e.message;
    } catch (e) {
      // Handle unexpected errors
      return "An unexpected error occurred.";
    }
  }

  /// Logs in an existing user with email and password.
  ///
  /// Returns:
  /// - null on success
  /// - Error message string on failure
  Future<String?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return e.message; // Firebase-specific error message
    } catch (e) {
      return "An unexpected error occurred.";
    }
  }

  /// Logs out the currently authenticated user.
  Future<void> logout() async => await _auth.signOut();

  /// Returns the currently signed-in user, or null if not signed in.
  User? get currentUser => _auth.currentUser;
}
