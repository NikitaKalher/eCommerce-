import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TChipTheme {
  TChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: TColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: TColors.black),
    selectedColor: TColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: TColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: TColors.darkGrey,
    labelStyle: TextStyle(color: TColors.white),
    selectedColor: TColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: TColors.white,
  );
}