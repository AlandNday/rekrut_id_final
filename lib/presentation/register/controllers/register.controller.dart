import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rekrut_id_final/Models/user_model.dart';
import 'package:rekrut_id_final/infrastructure/navigation/routes.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController
  // Text editing controllers for input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // GetStorage instance for local data persistence
  final GetStorage _box = GetStorage();

  // Observable for loading state
  var isLoading = false.obs;

  // Replace with your actual API base URL
  final String baseUrl =
      'https://backend-rekruit-id-production.up.railway.app/api'; // e.g., 'http://192.168.1.5:8000/api' or 'https://api.yourdomain.com/api'

  Future<void> register() async {
    // Validate inputs
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true; // Show loading indicator

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'), // Your register API endpoint
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'password_confirmation': confirmPasswordController
              .text, // Ensure your API expects this field
        }),
      );

      isLoading.value = false; // Hide loading indicator

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 200 or 201 for successful creation
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['message'] == 'User registered successfully') {
          // Parse user data and token
          final User user = User.fromJson(responseData['user']);
          final String token = responseData['token'];

          // Store user data and token locally using GetStorage
          _box.write('token', token);
          _box.write('user', user.toJson());

          Get.snackbar(
            'Success',
            'Registration successful! Welcome ${user.name}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          // Navigate to home screen or dashboard
          Get.offAllNamed(Routes.HOME); // Clear navigation stack
        } else {
          Get.snackbar(
            'Registration Failed',
            responseData['message'] ?? 'An unknown error occurred.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        // Handle HTTP errors
        final Map<String, dynamic> errorData = json.decode(response.body);
        String errorMessage = 'Server error: ${response.statusCode}';
        if (errorData.containsKey('errors')) {
          // Handle Laravel validation errors (often nested)
          final errors = errorData['errors'] as Map<String, dynamic>;
          errorMessage = errors.values.expand((e) => e as List).join('\n');
        } else if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        }

        Get.snackbar(
          'Registration Failed',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false; // Hide loading indicator on exception
      Get.snackbar(
        'Error',
        'Could not connect to the server. Please check your internet connection or API URL. Error: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Register Error: $e'); // For debugging
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
