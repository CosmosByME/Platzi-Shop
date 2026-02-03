import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/icons/app_icons.dart';
import 'package:myapp/core/l10n/app_strings.dart';
import 'package:myapp/core/routes/router.dart';

class Main extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  const Main({super.key, required this.child, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: AppIcons.homeUnselected,
            activeIcon: AppIcons.homeSelected,
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: AppIcons.catalogUnselected,
            activeIcon: AppIcons.catalogSelected,
            label: AppStrings.catalog,
          ),
          BottomNavigationBarItem(
            icon: AppIcons.cartUnselected,
            activeIcon: AppIcons.cartSelected,
            label: AppStrings.cart,
          ),
          BottomNavigationBarItem(
            icon: AppIcons.favoriteUnselected,
            activeIcon: AppIcons.favoriteSelected,
            label: AppStrings.favorite,
          ),
          BottomNavigationBarItem(
            icon: AppIcons.profileUnselected,
            activeIcon: AppIcons.profileSelected,
            label: AppStrings.profile,
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          if (currentIndex != index) {
            String page = switch (index) {
              0 => Routes.home,
              1 => Routes.catalog,
              2 => Routes.cart,
              3 => Routes.favorite,
              4 => Routes.profile,
              _ => Routes.home,
            };

            context.go(page);
          }
        },
      ),
    );
  }
}
