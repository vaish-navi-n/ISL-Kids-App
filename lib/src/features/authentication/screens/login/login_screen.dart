import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isl_kids_app/src/features/authentication/repository/authentication_repository.dart';
import 'package:isl_kids_app/src/features/authentication/screens/forgot_password/forgot_password_options/forgot_password_bottom_sheet.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: LoginFormWidget(),
      ),
    );
  }
}

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
    print("Login started");
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final error = await AuthenticationRepository.instance.loginWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      setState(() => _isLoading = false);

      if (error == null) {
        print("Login success"); 
        Get.offAllNamed('/dashboard');
        print;("Login error: $error");
        Get.snackbar('Login Error', error!, snackPosition: SnackPosition.BOTTOM);
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => value == null || !value.contains('@') ? 'Enter a valid email' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) => value == null || value.length < 6 ? 'Password must be at least 6 characters' : null,
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                ForgetPasswordScreen.buildShowModalBottomSheet(context);
              },
              child: const Text("Forgot Password?"),
            ),
          ),
          const SizedBox(height: 10),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(onPressed: _login, child: const Text('Login')),
          const SizedBox(height: 10),
          TextButton.icon(
            onPressed: () async {
              final error = await AuthenticationRepository.instance.signInWithGoogle();
              if (error == null) {
                Get.offAllNamed('/dashboard');
              } else {
                Get.snackbar('Google Sign-In Error', error, snackPosition: SnackPosition.BOTTOM);
              }
            },

            icon: Image.asset('assets/images/google_logo.png', height: 24),
            label: const Text("Login with Google"),
          ),
          const Spacer(),
          Center(
            child: TextButton(
              onPressed: () => Get.toNamed('/signup'),
              child: const Text("Don't have an account? Sign Up"),
            ),
          ),
        ],
      ),
    );
  }
}


