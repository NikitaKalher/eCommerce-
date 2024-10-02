import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

class TFormDivider extends StatelessWidget {
  const TFormDivider({
    super.key,
    required this.dark, required dividerText,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible (child: Divider(color: dark ? TColors.darkGrey : TColors.grey, thickness: 0.5 , indent: 60, endIndent: 5)),
        Text(TTexts.orSignInWith, style: Theme.of(context).textTheme.labelMedium),
        Flexible (child: Divider(color: dark ? TColors.darkGrey : TColors.grey, thickness: 0.5 , indent: 5, endIndent: 60)),
      ],
    );
  }
}
