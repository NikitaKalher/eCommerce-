import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  // Provides a singleton instance of this controller
  static OnboardingController get instance => Get.find();

  // A PageController to control the onboarding pages
  final pageController = PageController();

  // Observable variable to track the current page index
  Rx<int> currentPageIndex = 0.obs;

  // Local storage instance from GetStorage
  final deviceStorage = GetStorage();

  // Update the current page index when the user scrolls through the onboarding pages
  void updatePageIndicator(int index) => currentPageIndex.value = index;

  // Jump to a specific page when a dot indicator is clicked
  void dotNavigationClick(int index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  // Move to the next onboarding page or finish the onboarding process if it's the last page
  void nextPage() {
    if (currentPageIndex.value == 2) {  // Check if it's the last page
      // Mark that the user has finished onboarding
      deviceStorage.write('IsFirstTime', false);

      // Debugging: Print the updated value of 'IsFirstTime' from local storage
      if (kDebugMode) {
        print('==========================GET STORAGE========================');
        print(deviceStorage.read('IsFirstTime'));
      }

      // Navigate to the login screen after onboarding is complete
      Get.offAll(const LoginScreen());
    } else {
      // If it's not the last page, move to the next page
      int page = currentPageIndex.value + 1;
      pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut
      );
    }
  }

  // Skip directly to the last page and finish the onboarding process
  void skipPage() {
    currentPageIndex.value = 2;  // Set the index to the last page
    deviceStorage.write('IsFirstTime', false);  // Mark onboarding as complete
    Get.offAll(const LoginScreen());  // Navigate to the login screen
  }
}
