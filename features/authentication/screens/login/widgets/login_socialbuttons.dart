import 'package:ecommerce/features/authentication/controllers/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class TSocialButtons extends StatelessWidget {
  const TSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(LoginController());

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: TColors.grey), borderRadius: BorderRadius.circular(156)),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: const Image(
                width: TSizes.iconMd,
                height: TSizes.iconMd,
                image: AssetImage(TImages.google)
            ),
          ),
        ),
        const SizedBox(width: TSizes.spacesBtwItems),
        Container(
          decoration: BoxDecoration(border: Border.all(color: TColors.grey), borderRadius: BorderRadius.circular(156)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
                width: TSizes.iconMd,
                height: TSizes.iconMd,
                image: AssetImage(TImages.facebook)
            ),
          ),
        ),
      ],
    );
  }
}
