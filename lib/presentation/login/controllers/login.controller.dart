import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rekrut_id_final/Models/user_model.dart';
import 'package:rekrut_id_final/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:rekrut_id_final/infrastructure/navigation/routes.dart';
import 'package:rekrut_id_final/presentation/home/controllers/home.controller.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  // Text editing controllers for input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final HomeController homepagecontroller = Get.find<HomeController>();

  // GetStorage instance for local data persistence
  final GetStorage _box = GetStorage();

  // Observable for loading state
  var isLoading = false.obs;

  // Replace with your actual API base URL
  final String baseUrl =
      'https://backend-rekruit-id-production.up.railway.app/api'; // e.g., 'http://192.168.1.5:8000/api' or 'https://api.yourdomain.com/api'

  Future<void> login() async {
    // Validate inputs
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter both email and password.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true; // Show loading indicator

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'), // Your login API endpoint
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      isLoading.value = false; // Hide loading indicator

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['message'] == 'Login successful') {
          // Parse user data and token
          final User user = User.fromJson(responseData['user']);
          final String token = responseData['token'];

          // Store user data and token locally using GetStorage
          _box.write('token', token);
          _box.write('user', user.toJson()); // Store user object as a map

          Get.snackbar(
            'Success',
            'Login successful! Welcome ${user.name}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          ;
          // Navigate to home screen or dashboard
          Get.offAllNamed(
            Routes.HOME,
            arguments: emailController.text,
          ); // Use offAllNamed to clear navigation stack
        } else {
          // Handle specific backend error messages
          Get.snackbar(
            'Login Failed',
            responseData['message'] ?? 'An unknown error occurred.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        // Handle HTTP errors (e.g., 401 Unauthorized, 404 Not Found)
        final Map<String, dynamic> errorData = json.decode(response.body);
        Get.snackbar(
          'Login Failed',
          errorData['message'] ?? 'Server error: ${response.statusCode}',
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
      print('Login Error: $e'); // For debugging
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
