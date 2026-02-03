import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/components/app_image_card.dart';
import 'package:myapp/core/routes/router.dart';
import 'package:myapp/core/theme/app_fonts.dart';
import 'package:myapp/core/theme/app_size.dart';
import 'package:myapp/models/category.dart';

class CatalogCard extends StatefulWidget {
  final Category catalog;
  const CatalogCard({super.key, required this.catalog});

  @override
  State<CatalogCard> createState() => _CatalogCardState();
}

class _CatalogCardState extends State<CatalogCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => context.go(Routes.categoryDetailWithId(widget.catalog.id)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppImageCard(imageUrl: widget.catalog.image),
          Padding(
            padding: AppSize.paddingL8R8T8,
            child: Text(
              widget.catalog.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
