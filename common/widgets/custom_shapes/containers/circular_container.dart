import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = EdgeInsets.zero,
    this.child,
    this.backGroundColor = TColors.white,
    this.margin = EdgeInsets.zero,
    this.showBorder = false,
    this.borderColor = TColors.borderPrimary,
  });

  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final Color backGroundColor;
  final Color borderColor;
  final EdgeInsetsGeometry? margin;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backGroundColor,
        border:  showBorder ? Border.all(color: TColors.grey) : null,
      ),
      child: child,
    );
  }
}
