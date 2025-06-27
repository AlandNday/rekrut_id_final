import 'package:get/get.dart';
import 'package:flutter/material.dart'; // Import for Get.snackbar colors if needed
import 'package:rekrut_id_final/infrastructure/navigation/routes.dart'; // Make sure this is correct

class HomeController extends GetxController {
  // Your existing count observable
  final count = 0.obs;

  // Observable to hold the logged-in user's name
  // It will be null or empty if no user is logged in
  var userName = Rxn<String>(); // Use Rxn for nullable reactive string

  @override
  void onInit() {
    super.onInit();
    userName.value = Get.arguments;
    // In a real app, you'd check for a persisted login session here
    // For now, userName will be null initially.
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  // --- New: Methods for user authentication state ---

  /// Method to set the logged-in user's name.
  /// Call this from your LoginController after successful authentication.
  void setLoggedInUser(String name) {
    userName.value = name;
  }

  /// Method to handle user logout.
  /// Call this from a logout button or wherever logout action is triggered.
  void logout() {
    userName.value = null; // Clear the user name on logout
    Get.snackbar(
      'Logged Out',
      'You have been successfully logged out.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(
        0.7,
      ), // Using direct color for consistency
      colorText: Colors.white,
    );
    // Navigate to the home screen or login screen after logout
    // Using offAllNamed to clear the navigation stack
    Get.offAllNamed(
      Routes.HOME,
    ); // Or Routes.LOGIN if you prefer to go back to login
  }
}
