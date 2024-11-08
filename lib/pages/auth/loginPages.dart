import 'package:flutter/material.dart';
import 'package:video_tape_store/widgets/my_button.dart';
import 'package:video_tape_store/widgets/my_textfield.dart';
import 'package:video_tape_store/services/auth_service.dart';
import 'package:video_tape_store/pages/home/homepage.dart';

class LoginPages extends StatelessWidget {
  LoginPages({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn(BuildContext context) {
    final username = usernameController.text;
    final password = passwordController.text;

    if (AuthService.loginAdmin(username, password)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF2D2D2D),
          title: const Text('Error'),
          content: const Text('Invalid username or password'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.local_movies,
                  size: 100,
                  color: Color(0xFF3498DB),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Video Tape Store',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forget password
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                MyButton(
                  onTap: () => signUserIn(context),
                  text: 'Sign In',
                ),
                const SizedBox(height: 25),
                const Text(
                  'Or continue with',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton(
                      'Google',
                      Icons.g_mobiledata_rounded, 
                      () {},
                    ),
                    const SizedBox(width: 20),
                    _socialButton(
                      'Apple',
                      Icons.apple,
                      () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          border: Border.all(color: Colors.grey.shade800),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          Icon(icon, size: 24, color: Colors.white),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}
}
