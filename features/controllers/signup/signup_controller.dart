import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/features/authentication/screens/signup/widgets/verify_email.dart';
import 'package:ecommerce/features/controllers/network_manager.dart';
import 'package:ecommerce/features/shop/models/user_model.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = true.obs; // observable for privacy acceptance
  final email = TextEditingController(); // controller for email input
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();

  // GlobalKey for the form
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> signup() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog('We are processing your information...', TImages.animation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(title: 'No Internet', message: 'Please check your internet connection and try again.');
        return;
      }

      // Validate the form
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading(); // Stop the loader if validation fails
        return;
      }

      // Privacy policy check
      if (!privacyPolicy.value) {
        TFullScreenLoader.stopLoading(); // Stop the loader if privacy policy not accepted
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'In order to create an account, you must read and accept the Privacy Policy & Terms of Use.',
        );
        return;
      }

      // Register user
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Stop the loader before navigation
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been created! Verify email to continue.',
      );

      // Debugging log
      print("Navigating to VerifyEmailScreen");

      // move to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));

    }  catch (e) {
      // show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

}
