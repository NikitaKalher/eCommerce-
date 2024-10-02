import 'package:ecommerce/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final Color? color = THelperFunctions.getColor(text);
    final bool isColor = color != null;

    return ChoiceChip(
      label: isColor
          ? TCircularContainer(width: 24, height: 24, backGroundColor: color!)
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(text, style: TextStyle(color: selected ? TColors.white : null)),
      ),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(color: selected ? TColors.white : null),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      padding: isColor ? const EdgeInsets.all(0) : null,
      selectedColor: Colors.green,
      backgroundColor: isColor ? color! : null,
    );
  }
}
