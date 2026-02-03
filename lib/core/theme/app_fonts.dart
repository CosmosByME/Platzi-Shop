import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/core/theme/app_colors.dart';
import 'package:myapp/core/theme/app_size.dart';

class AppTextStyles {
  static TextStyle get headlineMedium => GoogleFonts.lora(
    fontSize: AppSize.fs32,
    color: AppColors.black,
  );

  static TextStyle get title => GoogleFonts.lora(
    fontSize: AppSize.fs20,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static TextStyle get subtitle => GoogleFonts.lora(
    fontSize: AppSize.fs20,
    fontWeight: FontWeight.w500,
    color: AppColors.black
  );

  static TextStyle get body => GoogleFonts.lora(
    fontSize: AppSize.fs18,
    color: AppColors.black
  );

  static TextStyle get buttonText => GoogleFonts.nunito(
    fontSize: AppSize.fs20,
    fontWeight: FontWeight.w500,
    color: AppColors.white
  );

  static TextStyle get inputText => GoogleFonts.nunito(
    fontSize: AppSize.fs16,
    color: AppColors.black,
  );
}
