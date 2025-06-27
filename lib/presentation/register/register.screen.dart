import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../infrastructure/navigation/routes.dart';
import 'controllers/register.controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});
  // Define static color constants, mirroring HomeScreen for consistency.
  static const Color primaryColor = Color(0xFF4A148C); // Dark purple background
  static const Color accentColor = Color(
    0xFFE040FB,
  ); // Vibrant pink/light purple for accents
  static const Color textColor = Colors.white; // General text color
  static const Color secondaryTextColor = Color(
    0xFFB39DDB,
  ); // Lighter purple for subtle text/icons
  static const Color cardColor = Color(
    0xFF6A1B9A,
  ); // Slightly lighter purple for card backgrounds

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(),
              const SizedBox(height: 50),
              _buildRegisterForm(),
              const SizedBox(height: 30),
              _buildLoginPrompt(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the "R" logo, similar to the HomeScreen header.
  Widget _buildLogo() {
    return Transform.rotate(
      angle: 270, // Convert degrees to radians
      child: const Text(
        'R',
        style: TextStyle(
          color: textColor,
          fontSize: 100,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  /// Builds the registration form with various input fields.
  Widget _buildRegisterForm() {
    return Container(
      width: 400, // Fixed width for the register card
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Join RekrutID!',
            style: TextStyle(
              color: textColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Create your account to start finding your dream job.',
            style: TextStyle(color: secondaryTextColor, fontSize: 16),
          ),
          const SizedBox(height: 30),
          _buildTextField(controller.nameController, 'Full Name', Icons.person),
          const SizedBox(height: 20),
          _buildTextField(
            controller.emailController,
            'Email Address',
            Icons.email,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller.passwordController,
            'Password',
            Icons.lock,
            obscureText: true,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller.confirmPasswordController,
            'Confirm Password',
            Icons.lock,
            obscureText: true,
          ),
          const SizedBox(height: 30),
          _buildElevatedButton('Register', () {
            controller.register();
          }),
        ],
      ),
    );
  }

  /// Helper widget for creating styled text input fields.
  Widget _buildTextField(
    TextEditingController controller,
    String hintText,
    IconData icon, {
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: textColor),
      cursorColor: accentColor, // Cursor color for consistency
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: secondaryTextColor.withOpacity(0.7)),
        prefixIcon: Icon(icon, color: secondaryTextColor),
        filled: true,
        fillColor: primaryColor.withOpacity(0.5), // Match primary color opacity
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none, // No border by default
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: accentColor,
            width: 2,
          ), // Accent border on focus
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none, // Keep consistent when not focused
        ),
      ),
    );
  }

  /// Helper widget for creating a styled elevated button.
  Widget _buildElevatedButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity, // Make button fill width
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor, // Button background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          elevation: 5, // Add a slight shadow for depth
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Builds the prompt for existing users to log in.
  Widget _buildLoginPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: TextStyle(color: secondaryTextColor, fontSize: 16),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(Routes.LOGIN); // Navigate to the login screen
          },
          child: Text(
            'Login',
            style: TextStyle(
              color: accentColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
