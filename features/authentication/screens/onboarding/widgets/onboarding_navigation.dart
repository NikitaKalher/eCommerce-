import 'package:ecommerce/features/authentication/onboarding/onboarding_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OnboardingNavigation extends StatelessWidget {

  final PageController pageController; // Add a field to hold the page controller

   const OnboardingNavigation({
    super.key,
    required this.pageController, // Require pageController as a parameter
  });

  @override
  Widget build(BuildContext context) {
    final controller  = OnboardingController.instance;

    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() * 0.25,
      left: TSizes.defaultSpace,
      child: SmoothPageIndicator(
        count: 3,
        controller: controller.pageController, // Use the provided page controller
        onDotClicked: controller.dotNavigationClick,
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? TColors.light : TColors.dark,
          dotHeight: 6,
        ),
      ),
    );
  }
}
