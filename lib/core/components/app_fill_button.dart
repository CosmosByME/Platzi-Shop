import 'package:flutter/material.dart';
import 'package:myapp/core/theme/app_size.dart';

import '../theme/app_colors.dart';

class AppFillButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const AppFillButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: AppSize.paddingH24,
        fixedSize: Size(MediaQuery.sizeOf(context).width, 50),
        backgroundColor: AppColors.black,
        overlayColor: AppColors.white,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}