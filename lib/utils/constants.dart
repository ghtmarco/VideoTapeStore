import 'package:flutter/material.dart';

/// App theme colors used throughout the application
class AppColors {
  // Primary colors
  static const primaryColor = Color(0xFF3498DB);      // Blue
  static const secondaryColor = Color(0xFF2ECC71);    // Green
  static const backgroundColor = Color(0xFF1A1A1A);   // Dark background
  static const surfaceColor = Color(0xFF2D2D2D);      // Card/Surface color
  
  // Text colors
  static const primaryTextColor = Color(0xFFECDFCC);  // Light text
  static const secondaryTextColor = Color(0xFF697565);// Subdued text
  
  // State colors
  static const successColor = Color(0xFF4CAF50);      // Success green
  static const errorColor = Color(0xFFE74C3C);        // Error red
  static const warningColor = Color(0xFFF1C40F);      // Warning yellow
  
  // UI element colors
  static const activeElementColor = Color(0xFFECDFCC);
  static const inactiveElementColor = Color(0xFF3C3D37);
  static const dividerColor = Color(0xFF404040);
}

/// Text styles used throughout the application
class AppTextStyles {
  // Heading styles
  static const headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryTextColor,
  );

  static const headingMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryTextColor,
  );

  static const headingSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryTextColor,
  );

  // Body text styles
  static const bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryTextColor,
  );

  static const bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryTextColor,
  );

  static const bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryTextColor,
  );

  // Special text styles
  static const buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const priceText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
  );
}

/// Standard dimensions and spacing used throughout the application
class AppDimensions {
  // Padding
  static const paddingSmall = 8.0;
  static const paddingMedium = 16.0;
  static const paddingLarge = 24.0;
  
  // Margins
  static const marginSmall = 8.0;
  static const marginMedium = 16.0;
  static const marginLarge = 24.0;
  
  // Border radius
  static const borderRadiusSmall = 8.0;
  static const borderRadiusMedium = 12.0;
  static const borderRadiusLarge = 16.0;
  
  // Icon sizes
  static const iconSizeSmall = 16.0;
  static const iconSizeMedium = 24.0;
  static const iconSizeLarge = 32.0;
}

/// String constants used throughout the application
class AppStrings {
  // App name
  static const appName = 'Video Tape Store';
  
  // Authentication strings
  static const login = 'Login';
  static const signup = 'Sign Up';
  static const forgotPassword = 'Forgot Password?';
  static const email = 'Email';
  static const password = 'Password';
  static const confirmPassword = 'Confirm Password';
  
  // Button texts
  static const addToCart = 'Add to Cart';
  static const checkout = 'Checkout';
  static const continue_ = 'Continue';
  static const cancel = 'Cancel';
  
  // Messages
  static const addedToCart = 'Item added to cart';
  static const purchaseSuccess = 'Thank you for your purchase!';
  static const loginError = 'Invalid username or password';
}