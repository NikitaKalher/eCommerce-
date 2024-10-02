import 'package:ecommerce/features/authentication/controllers/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';  // Import the GetX package
import 'package:ecommerce/common/styles/spacing_styles.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/login_form.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/login_form_divider.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/login_header.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/login_socialbuttons.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the LoginController
    Get.lazyPut(() => LoginController());

    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // logo, title, subtitle
              TLoginHeader(dark: dark),

              // form
              const TLoginForm(),

              // divider
              TFormDivider(dark: dark, dividerText: null,),
              const SizedBox(height: TSizes.spaceBtwSections),

              // footer
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
