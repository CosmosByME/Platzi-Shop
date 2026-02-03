import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/components/app_image_card.dart';
import 'package:myapp/core/icons/app_icons.dart';
import 'package:myapp/core/routes/router.dart';
import 'package:myapp/core/theme/app_fonts.dart';
import 'package:myapp/core/theme/app_size.dart';
import 'package:myapp/models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        context.go(Routes.productWithId(widget.product.id));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppImageCard(imageUrl: widget.product.images.first),
          Padding(
            padding: AppSize.paddingL8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.product.price}\$',
                  style: AppTextStyles.subtitle,
                ),
                IconButton(onPressed: () {}, icon: AppIcons.heart),
              ],
            ),
          ),
          Padding(
            padding: AppSize.paddingL8R8,
            child: Text(
              widget.product.title,
              style: AppTextStyles.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
