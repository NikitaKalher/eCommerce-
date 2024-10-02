import 'package:flutter/material.dart';

class TBottomSheetTheme{
  TBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    modalBackgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.black,
    constraints: const BoxConstraints(minWidth: double.infinity),
    modalBackgroundColor: Colors.black,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}
