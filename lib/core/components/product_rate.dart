import 'package:flutter/material.dart';
import 'package:myapp/core/icons/app_icons.dart';
import 'package:myapp/core/theme/app_colors.dart';
import 'package:myapp/core/theme/app_size.dart';

class ProductRate extends StatelessWidget {
  const ProductRate({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < 5; i++)
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: AppIcons.startFill.copyWith(width: 26, height: 24),
          ),
        AppSize.w10,
        const Text(
          "5,0",
          style: TextStyle(
            fontSize: 20,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
