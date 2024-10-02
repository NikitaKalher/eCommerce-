import 'package:ecommerce/features/personalization/controller/user_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = UserController.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('Re-Authenticate User')),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email
                  TextFormField(
                    controller: controller.verifyEmail,
                    validator: TValidator.validateEmail,
                    decoration: InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: TTexts.email),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  // password
                  Obx(
                    ()=> TextFormField(
                      obscureText: controller.hidePassword.value,
                      controller: controller.verifyPassword,
                      validator: (value) => TValidator.validateEmptyText('Password', value),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.password_check), 
                          labelText: TTexts.password,
                        suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value = !controller.hidePassword.value, 
                            icon: const Icon(Iconsax.eye_slash),
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  
                  // LOGIN BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => controller.reAuthenticateEmailAndPasswordUser(), 
                        child: const Text('Delete Account',)
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
