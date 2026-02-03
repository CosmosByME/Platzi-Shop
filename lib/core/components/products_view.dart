import 'package:flutter/material.dart';
import 'package:myapp/core/components/product_card.dart';
import 'package:myapp/models/product.dart';

class ProductView extends StatelessWidget {
  final List<Product> products;
  final ScrollController? controller;
  const ProductView({super.key, this.controller, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      controller: controller,
      shrinkWrap: true,
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
        childAspectRatio: 4 / 6.6,
      ),
      itemBuilder: (_, i) => ProductCard(product: products[i]),
    );
  }
}
