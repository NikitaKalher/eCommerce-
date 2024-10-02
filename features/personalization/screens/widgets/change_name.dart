import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/features/controllers/update_name_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/text_strings.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(UpdateNameController());
    return Scaffold(
      // custom appbar
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Change Name', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Headings
            Text(
              'Use real name for easy verification. This name will appear on several pages',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Text field and Button
            Form(
                key: controller.updateUserNameFormKey, // Add the form key
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) => TValidator.validateEmptyText('First Name', value),
                      decoration: const InputDecoration(
                        labelText: TTexts.firstName,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) => TValidator.validateEmptyText('Last Name', value),
                      decoration: const InputDecoration(
                        labelText: TTexts.lastName,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                  ],
                )
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.updateUserNameFormKey.currentState?.validate() ?? false) {
                    controller.updateUserName(); // Call the updateUserName function
                  }
                },
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
