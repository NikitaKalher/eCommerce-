import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../onboarding/onboarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + kToolbarHeight / 2, // Standard AppBar height
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnboardingController.instance.skipPage(),
        child: const Text('Skip')),
    );
  }
}
