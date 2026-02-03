import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/components/app_fill_button.dart';
import 'package:myapp/core/components/app_text_field.dart';
import 'package:myapp/core/components/profile_image.dart';
import 'package:myapp/core/l10n/app_strings.dart';
import 'package:myapp/core/providers/auth_provider.dart';
import 'package:myapp/core/routes/router.dart';
import 'package:myapp/core/theme/app_fonts.dart';
import 'package:myapp/core/theme/app_size.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _signUp() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter the datas completely!")));
      return;
    }

    final success =
        await context.read<AuthProvider>().signUp(_nameController.text, _emailController.text, _passwordController.text);
    if (success && mounted) {
      context.go(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSize.paddingAll16,
          child: Consumer<AuthProvider>(builder: (context, provider, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppSize.h100,
                ProfileImage(enabled: !provider.loading),
                AppSize.h24,
                Text(AppStrings.createAccount, style: AppTextStyles.headlineMedium),
                AppSize.h24,
                AppTextField(
                    controller: _nameController,
                    iconData: CupertinoIcons.person,
                    hintText: AppStrings.name,
                    enabled: !provider.loading),
                AppSize.h16,
                AppTextField(
                    controller: _emailController,
                    iconData: CupertinoIcons.envelope,
                    hintText: AppStrings.email,
                    enabled: !provider.loading),
                AppSize.h16,
                AppTextField(
                    controller: _passwordController,
                    iconData: CupertinoIcons.padlock_solid,
                    hintText: AppStrings.password,
                    obscureText: true,
                    enabled: !provider.loading),
                AppSize.h16,
                AppTextField(
                    controller: _confirmPasswordController,
                    iconData: CupertinoIcons.padlock_solid,
                    hintText: AppStrings.confirmPassword,
                    obscureText: true,
                    enabled: !provider.loading),
                AppSize.h48,
                AppFillButton(
                  onPressed: provider.loading ? null : _signUp,
                  child: provider.loading
                      ? const CircularProgressIndicator(color: AppColors.white, strokeWidth: 2)
                      : Text(AppStrings.signUp, style: AppTextStyles.buttonText),
                ),
                AppSize.h24,
                RichText(
                    text: TextSpan(style: AppTextStyles.inputText.copyWith(fontSize: 20), children: [
                  const TextSpan(text: AppStrings.loginPrompt, style: TextStyle(color: AppColors.greyText)),
                  TextSpan(
                      text: AppStrings.login, recognizer: TapGestureRecognizer()..onTap = () => context.go(Routes.login)),
                ])),
              ],
            );
          }),
        ),
      ),
    );
  }
}