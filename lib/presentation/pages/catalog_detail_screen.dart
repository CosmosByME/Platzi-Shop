import 'package:flutter/material.dart';
import 'package:myapp/core/components/search_button.dart';
import 'package:myapp/core/l10n/app_strings.dart';
import 'package:myapp/core/components/products_view.dart';
import 'package:myapp/core/theme/app_colors.dart';
import 'package:myapp/core/theme/app_size.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/network/apis.dart';
import 'package:myapp/network/network.dart';

class CatalogDetailScreen extends StatelessWidget {
  final String catalogID;
  const CatalogDetailScreen({super.key, required this.catalogID});

  Future<List<Product>> _products(String categoryID) async {
    final data = await Network.request(
      api: Apis.productsByCategory(categoryID),
    );
    if (data != null) {
      return Network.parseProducts(data);
    } else {
      throw Exception("Failed to load products");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(AppStrings.product),
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        actions: [
          SearchButton(),
          AppSize.w12,
        ],
      ),
      body: FutureBuilder(
        future: _products(catalogID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return SizedBox.shrink();
            }
            return ProductView(products: snapshot.data!);
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
