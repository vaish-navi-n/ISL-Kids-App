import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isl_kids_app/src/features/authentication/repository/authentication_repository.dart';

class ForgetPasswordMailScreen extends StatefulWidget {
  const ForgetPasswordMailScreen({super.key});

  @override
  State<ForgetPasswordMailScreen> createState() => _ForgetPasswordMailScreenState();
}

class _ForgetPasswordMailScreenState extends State<ForgetPasswordMailScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final error = await AuthenticationRepository.instance
          .sendPasswordResetEmail(_emailController.text.trim());

      setState(() => _isLoading = false);

      if (error == null) {
        Get.snackbar(
          'Success',
          'Password reset email sent. Please check your inbox.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          error,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Text(
                  "FORGOT PASSWORD",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Enter your email address to receive a password reset link.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    label: Text("Email"),
                    hintText: "Email",
                    prefixIcon: Icon(Icons.mail_outline_rounded),
                  ),
                  validator: (value) =>
                      value == null || !value.contains('@') ? "Enter a valid email" : null,
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _resetPassword,
                          child: const Text("Send Reset Link"),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
