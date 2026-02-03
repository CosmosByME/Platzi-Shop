import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/core/theme/app_colors.dart';
import 'package:myapp/core/theme/app_fonts.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      surface: AppColors.white,
      onSurface: AppColors.black,
    ),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      elevation: 0,
    ),
    textTheme: GoogleFonts.loraTextTheme().copyWith(
      headlineMedium: AppTextStyles.headlineMedium,
      titleLarge: AppTextStyles.title,
      titleMedium: AppTextStyles.subtitle,
      bodyLarge: AppTextStyles.body,
      labelLarge: AppTextStyles.buttonText,
      labelMedium: AppTextStyles.inputText
    ),
  );
}
