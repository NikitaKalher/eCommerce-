import 'package:ecommerce/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:ecommerce/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/text_strings.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ForgetPasswordController());

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // headings
            Text(TTexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spacesBtwItems),
            Text(TTexts.forgetPasswordTitleSubTitle, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: TSizes.spaceBtwSections * 2),

            // text fields
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: TValidator.validateEmail,
                decoration: const InputDecoration(labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct_right)),
              ),
            ),
            const SizedBox(height: TSizes.spacesBtwItems),

            // submit button
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.sendPasswordResetEmail(), child: const Text(TTexts.submit)))
          ],
        ),
      ),
    );
  }
}