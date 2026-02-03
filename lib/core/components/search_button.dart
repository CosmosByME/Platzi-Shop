import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/components/app_image_card.dart';
import 'package:myapp/core/icons/app_icons.dart';
import 'package:myapp/core/providers/home_provider.dart';
import 'package:myapp/core/routes/router.dart';
import 'package:myapp/core/theme/app_size.dart';
import 'package:myapp/models/product.dart';
import 'package:provider/provider.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => search(context),
      icon: const Icon(Icons.search),
    );
  }

  void search(BuildContext context) async {
    final product = await showSearch(
      context: context,
      delegate: _ProductSearchDelegate(),
    );

    if (product != null && context.mounted) {
      context.go(Routes.productWithId(product.id));
    }
  }
}

class _ProductSearchDelegate extends SearchDelegate<Product> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear),
        ),
      Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return IconButton(
            onPressed: query.isNotEmpty && !provider.loadingSearch
                ? () => provider.search(query)
                : null,
            icon: provider.loadingSearch
                ? const Padding(
                    padding: EdgeInsets.all(8),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    ),
                  )
                : AppIcons.search,
          );
        },
      ),
      AppSize.w12,
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) return SizedBox.shrink();

    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          itemBuilder: (context, index) => ListTile(
            leading: AppImageCard(
              imageUrl: provider.searchList[index].images.first,
            ),
            title: Text(provider.searchList[index].title),
            subtitle: Text(provider.searchList[index].description, maxLines: 2),
            onTap: () {
              final item = provider.searchList[index];
              provider.clearSearchList();
              close(context, item);
            },
          ),
          itemCount: provider.searchList.length,
        );
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(CupertinoIcons.chevron_back, color: Colors.black),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return SizedBox.shrink();

    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.searchList.isEmpty) return SizedBox.shrink();

        return ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title: Text(provider.searchList[index].title),
            onTap: () {
              query = provider.searchList[index].title;
              provider.search(query).then((value) {
                if (context.mounted) showResults(context);
              });
            },
          ),
          itemCount: provider.searchList.length,
        );
      },
    );
  }
}
