import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isl_kids_app/src/features/authentication/repository/authentication_repository.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  void _login() async {
    print("Login button pressed");
    if (_formKey.currentState!.validate()) {
      print("Form validated");
      setState(() => _isLoading = true);

      final error = await AuthenticationRepository.instance.loginWithEmailAndPassword(
        _emailController.text.trim(), 
        _passwordController.text.trim(),
        );
        setState(() => _isLoading = false);
        if (error == null) {
          print("Login successful, navigating to dashboard");
          Get.offAllNamed('/dashboard');
        } else {
          print("Login failed with error: $error"); 
          Get.snackbar('Login Error', error, snackPosition: SnackPosition.BOTTOM);
        } 

    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => value == null || !value.contains('@') ? 'Enter a valid email' : null,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) => value == null || value.length < 6 ? 'Password must be at least 6 characters' : null,
          ),
          const SizedBox(height: 24),
          _isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: _login,
                  child: const Text('LOGIN'),
                ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => Get.toNamed('/signup'),
            child: const Text('Don\'t have an account? SIGN UP'),
          ),
        ],
      ),
    );
  }
}
