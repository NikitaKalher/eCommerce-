import 'package:flutter/material.dart';
import '../../../features/shop/screens/store/t_brand_card.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/circular_container.dart';
import '../custom_shapes/containers/rounded_container.dart';

class TBrandShowCase extends StatelessWidget {
  const TBrandShowCase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      width: double.infinity,
      radius: 15,
      borderColor: TColors.darkGrey,
      backGroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: TSizes.spacesBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand with Products count
          const TBrandCard(showBorder: false),
          const SizedBox(height: TSizes.spacesBtwItems),

          // Brand tag 3 products images
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space the items evenly
            children: images
                .map((image) => Expanded(
              child: brandTopProductImageWidget(image, context),
            ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Container(
      padding: const EdgeInsets.all(TSizes.sm),
      child: TCircularContainer(
        radius: 20,
        width: 80,
        height: 80,
        backGroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.darkGrey
            : TColors.light,
        margin: const EdgeInsets.only(right: TSizes.sm),
        padding: const EdgeInsets.all(TSizes.md),
        child: Image(
          fit: BoxFit.contain,
          image: AssetImage(image),
        ),
      ),
    );
  }
}

