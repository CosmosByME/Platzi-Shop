import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/core/components/app_image_card.dart';
import 'package:myapp/core/icons/app_icons.dart';
import 'package:myapp/core/l10n/app_strings.dart';
import 'package:myapp/core/providers/auth_provider.dart';
import 'package:myapp/core/service/image_service.dart';
import 'package:myapp/core/theme/app_colors.dart';
import 'package:myapp/core/theme/app_fonts.dart';
import 'package:provider/provider.dart';

class ProfileImage extends StatelessWidget {
  final bool enabled;
  const ProfileImage({super.key, this.enabled = true});

  void _selectSource(BuildContext context) async {
    if (!enabled) return;

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(AppStrings.photoLibrary, style: AppTextStyles.inputText.copyWith(fontSize: 20)),
              onTap: () {
                Navigator.of(context).pop(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: Text(AppStrings.camera, style: AppTextStyles.inputText.copyWith(fontSize: 20)),
              onTap: () {
                Navigator.of(context).pop(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );

    if (context.mounted && source != null) _pickImage(context, source);
  }

  void _pickImage(BuildContext context, ImageSource source) async {
    final String? path = await ImageService.pick(source);
    if (context.mounted && path != null) {
      context.read<AuthProvider>().uploadAvatar(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectSource(context),
      child: Stack(
        children: [
          Container(
            height: 100,
            width: 100,
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              border: Border.all(color: AppColors.black, width: 2),
            ),
            child: Consumer<AuthProvider>(
              builder: (context, provider, _) {
                if (provider.avatarUrl != null) {
                  return AppImageCard(imageUrl: provider.avatarUrl!);
                }
                return AppIcons.logo.copyWith(height: 75, width: 75);
              },
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border: Border.all(color: AppColors.black),
              ),
              child: AppIcons.plus,
            ),
          ),
        ],
      ),
    );
  }
}
