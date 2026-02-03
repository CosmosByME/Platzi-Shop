import 'package:flutter/material.dart';
import 'package:myapp/core/components/products_view.dart';
import 'package:myapp/core/components/search_button.dart';
import 'package:myapp/core/l10n/app_strings.dart';
import 'package:myapp/core/providers/home_provider.dart';
import 'package:myapp/core/theme/app_colors.dart';
import 'package:myapp/core/theme/app_size.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  void listener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      context.read<HomeProvider>().fetchProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(AppStrings.appName),
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        actions: [
          SearchButton(),
          AppSize.w12
        ],
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: context.read<HomeProvider>().onRefresh,
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return ProductView(products: provider.items, controller: controller);
          },
        ),
      ),
    );
  }
}
