import 'package:flutter/material.dart';
import 'package:myapp/core/components/catalog_card.dart';
import 'package:myapp/core/l10n/app_strings.dart';
import 'package:myapp/core/providers/catalog_provider.dart';
import 'package:myapp/core/theme/app_colors.dart';
import 'package:myapp/core/theme/app_size.dart';
import 'package:provider/provider.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(AppStrings.catalog),
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
      ),
      body: const CatalogView(),
    );
  }
}

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CatalogProvider>(
      builder: (context, provider, child) {
        if (provider.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.category.isEmpty) {
          return const Center(child: Text("No categories found"));
        }

        return GridView.builder(
          padding: AppSize.paddingH16,
          itemCount: provider.category.length, // ✅ VERY IMPORTANT
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 16,
            childAspectRatio: 5 / 6,
          ),
          itemBuilder: (_, i) => CatalogCard(catalog: provider.category[i]),
        );
      },
    );
  }
}
