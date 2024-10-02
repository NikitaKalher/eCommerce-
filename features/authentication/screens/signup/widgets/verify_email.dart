import 'package:ecommerce/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/features/controllers/signup/verify_email_controller.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/text_strings.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    // Get.put is used to create new instance and get.find method is used to find already exist instance

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => AuthenticationRepository.instance.logout(),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // image
              Image.asset(
                TImages.emailVerification,
                width: THelperFunctions.screenWidth() * 0.6,
                height: 100,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // title & subtitle
              Text(
                TTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spacesBtwItems),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spacesBtwItems),
              Text(
                TTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.checkEmailVerificationStatus(),
                  child: const Text(TTexts.tContinue),
                ),
              ),
              const SizedBox(height: TSizes.spacesBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: controller.sendEmailVerification,
                  child: const Text(TTexts.resetEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
