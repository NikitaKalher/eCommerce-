import 'dart:async';
import 'package:ecommerce/common/widgets/loaders/loaders.dart';
import 'package:ecommerce/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  // send email whenever verify screen appears & set Timer for auto redirect.
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();

  }

  // send email verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(title: 'Email Sent', message: 'Please check your inbox and verify your email.');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Timer to automatically redirect on Email Verification
  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
        (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if(user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(
              () => SuccessScreen(
                  image: TImages.emailVerificationSuccessful,
                  title: TTexts.yourAccountCreatedTitle,
                  subTitle: TTexts.yourAccountCreatedSubTitle,
                  onPressed: () => AuthenticationRepository.instance.screenRedirect(),
              ),
          );
        }
        },
    );
  }

  // manually check if email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified) {
      Get.off(
          () => SuccessScreen(
              image: TImages.emailVerificationSuccessful,
              title: TTexts.yourAccountCreatedTitle,
              subTitle: TTexts.yourAccountCreatedSubTitle,
              onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ),
      );
    }
  }

}