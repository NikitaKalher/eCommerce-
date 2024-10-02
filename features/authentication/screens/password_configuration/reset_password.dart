import 'package:ecommerce/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // image
              Image(image: const AssetImage(TImages.emailVerification), width: THelperFunctions.screenWidth() * 0.6, height: 100,),
              const SizedBox(height: TSizes.spaceBtwSections),

              // title & subtitle
              Text(email, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spacesBtwItems),
              Text(TTexts.passwordResetEmailSentSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwSections),

              // buttons
              SizedBox(width: double.infinity,
                  child: ElevatedButton(onPressed: () => Get.offAll(() => const LoginScreen()), child: const Text(TTexts.done))),
              const SizedBox(height: TSizes.spacesBtwItems),
              SizedBox(width: double.infinity, child: TextButton(onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email), child: const Text(TTexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
