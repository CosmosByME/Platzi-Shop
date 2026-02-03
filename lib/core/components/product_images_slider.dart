import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/l10n/string_utils.dart';
import 'package:myapp/core/theme/app_colors.dart';

class ProductImagesSlider extends StatelessWidget {
  final List<String> images;
  const ProductImagesSlider({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PageView.builder(
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: StringUtils.extractUrlFromString(images[index]),
            placeholder: (_, __) => Container(color: AppColors.grey200),
            errorWidget: (_, __, ___) => Container(color: AppColors.grey200),
          );
        },
        itemCount: images.length,
      ),
    );
  }
}
