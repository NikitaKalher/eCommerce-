import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../image_text_widgets/t_brand_title_with_verified_icon.dart';
import '../images/T_Rounded_image.dart';
import '../texts/product_title_text.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Image
        TRoundedImage(
          imageUrl: TImages.productImage,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkGrey : TColors.light,
        ),
        const SizedBox(width: TSizes.spacesBtwItems),

        //-----------title, price an d size-----------
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBrandTitleWithVerifiedIcon(title: 'Nike', brandTextSize: TextSizes.small,),
              const TProductTitleText(title: 'White sports shoes', maxLines: 1),
              // Attributes
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Color', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'Green', style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(text: 'Size', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'UK 08', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
