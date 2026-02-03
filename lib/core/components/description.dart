import 'package:flutter/material.dart';
import 'package:myapp/core/l10n/app_strings.dart';
import 'package:myapp/core/theme/app_fonts.dart';
import 'package:myapp/core/theme/app_size.dart';

class Description extends StatelessWidget {
  const Description({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// #description
        Padding(
          padding: AppSize.paddingL16T8,
          child: Text(AppStrings.description, style: AppTextStyles.title),
        ),

        Padding(
          padding: AppSize.paddingL16T8R16B24,
          child: Text(description, style: AppTextStyles.body),
        ),
      ],
    );
  }
}
