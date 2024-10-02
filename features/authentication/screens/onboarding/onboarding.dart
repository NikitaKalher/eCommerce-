import 'package:ecommerce/features/authentication/screens/onboarding/widgets/onboarding_navigation.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../onboarding/onboarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(OnboardingController());

    final PageController pageController = PageController(); // Create PageController

    return Scaffold(
      body: Stack(
        children: [
          // horizontal scroll pages
          PageView(
            controller: controller.pageController,
           onPageChanged: controller.updatePageIndicator,
           children: const [
             OnBoardingPage(
              image: TImages.onBoardingImage1,
              title: TTexts.onBoardingTitle1,
              subTitle: TTexts.onBoardingSubTitle1,
          ),

          OnBoardingPage(
            image: TImages.onBoardingImage2,
            title: TTexts.onBoardingTitle2,
            subTitle: TTexts.onBoardingSubTitle2,
          ),

          OnBoardingPage(
            image: TImages.onBoardingImage3,
            title: TTexts.onBoardingTitle3,
            subTitle: TTexts.onBoardingSubTitle3,
          ),
        ],
     ),

          // skip button
         const OnBoardingSkip(),

          // dot navigation SmoothPageIndicator
         //const onboarding_navigation(),
          OnboardingNavigation(pageController: pageController), // Pass pageController here

          // circular button
         const OnBoardingNextButton()
        ],
    ),
    );
  }
}

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
        onPressed: () => OnboardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: dark ? TColors.primary : Colors.black),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}


