import 'package:flutter/material.dart';
import 'package:video_tape_store/utils/constants.dart';
import 'package:video_tape_store/widgets/custom_button.dart';
import 'package:video_tape_store/widgets/custom_textfield.dart';
import 'package:video_tape_store/pages/home/home_page.dart';
import 'package:video_tape_store/pages/auth/signup_page.dart';
import 'package:video_tape_store/pages/auth/reset_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  // Form validation helpers
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Simple email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Login function
  Future<void> _handleLogin() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      // TODO: Implement actual login logic with backend
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
      
      if (_emailController.text == 'admin@admin.com' && 
          _passwordController.text == 'admin123') {
        // Login successful
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      } else {
        // Login failed
        if (mounted) {
          _showErrorDialog('Invalid email or password');
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('An error occurred. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Error'),
        content: Text(message),
        backgroundColor: AppColors.surfaceColor,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo
                  Icon(
                    Icons.local_movies,
                    size: AppDimensions.iconSizeLarge * 3,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: AppDimensions.marginLarge * 2),

                  // App Title
                  Text(
                    AppStrings.appName,
                    style: AppTextStyles.headingLarge,
                  ),
                  const SizedBox(height: AppDimensions.marginLarge),

                  // Login Form
                  CustomTextField(
                    controller: _emailController,
                    label: AppStrings.email,
                    hint: 'Enter your email',
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppDimensions.marginMedium),

                  CustomTextField(
                    controller: _passwordController,
                    label: AppStrings.password,
                    hint: 'Enter your password',
                    isPassword: true,
                    validator: _validatePassword,
                  ),

                  // Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswordPage(),
                        ),
                      ),
                      child: Text(
                        AppStrings.forgotPassword,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.marginLarge),

                  // Login Button
                  CustomButton(
                    onPressed: _handleLogin,
                    text: AppStrings.login,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: AppDimensions.marginLarge),

                  // Social Login Divider
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(color: AppColors.dividerColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingMedium,
                        ),
                        child: Text(
                          'Or continue with',
                          style: AppTextStyles.bodySmall,
                        ),
                      ),
                      const Expanded(
                        child: Divider(color: AppColors.dividerColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.marginLarge),

                  // Social Login Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SocialLoginButton(
                        icon: Icons.g_mobiledata_rounded,
                        label: 'Google',
                        onTap: () {
                          // TODO: Implement Google Sign In
                        },
                      ),
                      const SizedBox(width: AppDimensions.marginLarge),
                      _SocialLoginButton(
                        icon: Icons.apple,
                        label: 'Apple',
                        onTap: () {
                          // TODO: Implement Apple Sign In
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.marginLarge),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppTextStyles.bodySmall,
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ),
                        ),
                        child: Text(
                          AppStrings.signup,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialLoginButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLarge,
          vertical: AppDimensions.paddingMedium,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
          border: Border.all(color: AppColors.dividerColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primaryTextColor),
            const SizedBox(width: AppDimensions.marginSmall),
            Text(label, style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }
}