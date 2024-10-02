import 'package:ecommerce/features/authentication/screens/login/widgets/login_socialbuttons.dart';
import 'package:ecommerce/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// title
              Text(TTexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// form
              const TSignupForm(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // divider
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible (child: Divider(color: dark ? TColors.darkGrey : TColors.grey, thickness: 0.5 , indent: 60, endIndent: 5)),
                Text(TTexts.orSignUpWith, style: Theme.of(context).textTheme.labelMedium),
                Flexible (child: Divider(color: dark ? TColors.darkGrey : TColors.grey, thickness: 0.5 , indent: 5, endIndent: 60)),
              ],
            ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // social buttons
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

