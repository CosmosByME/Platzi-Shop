import 'package:flutter/material.dart';

class AppSize {
  static const paddingAll16 = EdgeInsets.all(16);
  static const paddingH16 = EdgeInsets.symmetric(horizontal: 16);
  static const paddingH24 = EdgeInsets.symmetric(horizontal: 24);
  static const paddingH4 = EdgeInsets.symmetric(horizontal: 4);
  static const paddingH16V16 = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 16,
  );

  static const paddingL16 = EdgeInsets.only(left: 16);
  static const paddingL8 = EdgeInsets.only(left: 8);
  static const paddingL8R8 = EdgeInsets.only(left: 8, right: 8);
  static const paddingL8R8T8 = EdgeInsets.only(left: 8, right: 8, top: 8);
  static const paddingL16T8 = EdgeInsets.only(left: 16, top: 8);
  static const paddingL16T8R16B24 = EdgeInsets.only(
    left: 16,
    top: 8,
    right: 16,
    bottom: 24,
  );
  static const paddingT16L16R8 = EdgeInsets.only(top: 16, left: 16, right: 8);
  static const paddingT24L16R16B24 = EdgeInsets.only(
    top: 24,
    left: 16,
    right: 16,
    bottom: 24,
  );
  static const paddingR4 = EdgeInsets.only(right: 4);

  static const w4 = SizedBox(width: 4);
  static const w8 = SizedBox(width: 8);
  static const w10 = SizedBox(width: 10);
  static const w12 = SizedBox(width: 12);

  static const h8 = SizedBox(height: 8);
  static const h16 = SizedBox(height: 16);
  static const h24 = SizedBox(height: 24);
  static const h48 = SizedBox(height: 48);
  static const h30 = SizedBox(height: 30);
  static const h100 = SizedBox(height: 100);
  static const h200 = SizedBox(height: 200);

  // Font Sizes
  static const fs16 = 16.0;
  static const fs18 = 18.0;
  static const fs20 = 20.0;
  static const fs24 = 24.0;
  static const fs32 = 32.0;

  // Other Sizes
  static const zero = 0.0;
}
