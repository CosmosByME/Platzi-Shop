import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/theme/app_fonts.dart';
import 'package:myapp/core/theme/app_size.dart';
import '../theme/app_colors.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData iconData;
  final String hintText;
  final bool obscureText;
  final bool enabled;

  const AppTextField({
    required this.controller,
    required this.iconData,
    required this.hintText,
    this.obscureText = false,
    this.enabled = true,
    super.key,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.grey),
    );

    return TextField(
      enabled: widget.enabled,
      controller: widget.controller,
      style: AppTextStyles.inputText,
      cursorColor: Colors.black,
      obscureText: obscure,
      cursorHeight: 16,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.iconData),
        hintText: widget.hintText,
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () => setState(() => obscure = !obscure),
                icon: obscure
                    ? const Icon(CupertinoIcons.eye, color: AppColors.greyDark)
                    : const Icon(CupertinoIcons.eye_slash, color: AppColors.greyDark),
              )
            : null,
        contentPadding: AppSize.paddingL16,
        filled: true,
        fillColor: AppColors.grey,
        border: border,
        enabledBorder: border,
        disabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}