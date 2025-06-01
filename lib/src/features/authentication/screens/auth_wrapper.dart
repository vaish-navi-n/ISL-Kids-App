import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Required for User
import 'package:isl_kids_app/src/features/authentication/repository/authentication_repository.dart';
import 'login/login_screen.dart';
import 'dashboard/dashboard.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = AuthenticationRepository.instance;

    return StreamBuilder<User?>(
      stream: authRepo.authStateChanges(), // Fix: Use method from repository
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return const LoginScreen(); // Show login if not authenticated
          } else {
            return const Dashboard(); // Show dashboard if authenticated
          }
        } else {
          // While checking auth state
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
