import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../controllers/network_manager.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // send reset password email
  sendPasswordResetEmail() async {
    try{
      // start loading
      TFullScreenLoader.openLoadingDialog('Logging you in ...', TImages.animation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(title: 'No Internet', message: 'Please check your internet connection and try again.');
        return;
      }

      // Validate the form
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading(); // Stop the loader if validation fails
        return;
      }

      // send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      // remove loader
      TFullScreenLoader.stopLoading();

      // show success screen
      TLoaders.successSnackBar(title: 'Email sent', message: 'Email Link sent to Reset your password'.tr);

      // Redirect
      Get.to(() => ResetPassword(email: email.text.trim()));

    } catch (e) {
      // remove loader
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());

    }
  }

  resendPasswordResetEmail(String email) async {
    try{
      // start loading
      TFullScreenLoader.openLoadingDialog('Logging you in ...', TImages.animation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(title: 'No Internet', message: 'Please check your internet connection and try again.');
        return;
      }

      // send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.trim());

      // remove loader
      TFullScreenLoader.stopLoading();

      // show success screen
      TLoaders.successSnackBar(title: 'Email sent', message: 'Email Link sent to Reset your password'.tr);

    } catch (e) {
      // remove loader
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());

    }
  }


}