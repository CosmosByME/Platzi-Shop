import 'package:flutter/material.dart';
import 'package:myapp/core/components/description.dart';
import 'package:myapp/core/components/product_card.dart';
import 'package:myapp/core/components/product_images_slider.dart';
import 'package:myapp/core/components/product_rate.dart';
import 'package:myapp/core/icons/app_icons.dart';
import 'package:myapp/core/l10n/app_strings.dart';
import 'package:myapp/core/theme/app_colors.dart';
import 'package:myapp/core/theme/app_fonts.dart';
import 'package:myapp/core/theme/app_size.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/network/apis.dart';
import 'package:myapp/network/network.dart';

class ProductScreen extends StatefulWidget {
  final String id;
  const ProductScreen({super.key, required this.id});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Future<Product> fetchProduct() async {
    final data = await Network.request(api: Apis.products, id: widget.id);
    if (data != null) {
      return Network.parseProduct(data);
    } else {
      throw Exception("Failed to load product");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: fetchProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImagesSlider(images: product.images),

                  Padding(
                    padding: AppSize.paddingT16L16R8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.title,
                            style: AppTextStyles.title.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: AppIcons.heart.copyWith(height: 36, width: 36),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: AppSize.paddingAll16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const ProductRate(),
                        Text('${product.price}\$', style: AppTextStyles.title),
                      ],
                    ),
                  ),
                  Divider(height: 2, color: AppColors.grey200),

                  const Padding(
                    padding: AppSize.paddingT24L16R16B24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// #quantity
                        _ProductQuantity(),

                        /// #add to cart
                        _AddToCart(),
                      ],
                    ),
                  ),

                  Description(description: product.description),

                  _SimilarProduct(product: product),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}



class _AddToCart extends StatelessWidget {
  const _AddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: AppSize.paddingH24,
        fixedSize: const Size(double.nan, 50),
        backgroundColor: AppColors.black,
        overlayColor: AppColors.white,
      ),
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcons.cartSelected.copyWith(color: AppColors.white),
          AppSize.w8,
          Text(
            AppStrings.addToCart,
            style: AppTextStyles.buttonText,
          ),
        ],
      ),
    );
  }
}

class _ProductQuantity extends StatelessWidget {
  const _ProductQuantity({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSize.w4,
          IconButton(
            onPressed: () {},
            icon: AppIcons.minus.copyWith(height: 32, width: 32),
          ),
          AppSize.w8,
          const Text(
            "1",
            style: TextStyle(
              fontSize: 20,
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          AppSize.w8,
          IconButton(
            onPressed: () {},
            icon: AppIcons.plus.copyWith(height: 28, width: 28),
          ),
          AppSize.w4,
        ],
      ),
    );
  }
}


class _SimilarProduct extends StatelessWidget {
  final Product product;

  const _SimilarProduct({required this.product, super.key});

  Future<List<Product>> _similarProducts(int categoryID, int productID) async {
    final data = await Network.request(api: Apis.productsByCategory('$categoryID'));
    if (data != null) {
      return Network.parseProducts(data)..removeWhere((item) => item.id == productID);
    } else {
      throw Exception('Failed to load Product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33 * MediaQuery.sizeOf(context).width / 43 + 72,
      child: FutureBuilder<List<Product>>(
        future: _similarProducts(product.category.id, product.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) return const SizedBox.shrink();
            final items = snapshot.data!;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// #similar products
                Padding(
                  padding: AppSize.paddingL16T8,
                  child: Text(
                    AppStrings.similarProducts,
                    style: AppTextStyles.title,
                  ),
                ),

                Flexible(
                  child: ListView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: AppSize.paddingH16V16,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: MediaQuery.sizeOf(context).width / 2.15,
                        child: Padding(
                          padding: AppSize.paddingH4,
                          child: ProductCard(product: items[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}