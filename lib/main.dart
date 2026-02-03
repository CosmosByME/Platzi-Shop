import 'package:flutter/material.dart';
import 'package:myapp/core/providers/auth_provider.dart';
import 'package:myapp/core/providers/catalog_provider.dart';
import 'package:myapp/core/providers/home_provider.dart';
import 'package:myapp/core/routes/router.dart';
import 'package:myapp/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(
          create: (context) => HomeProvider()..fetchProducts(),
        ),
        ChangeNotifierProvider(create: (_) => CatalogProvider()..fetchAll()),
      ],
      child: MaterialApp.router(
        theme: AppTheme.light,
        routerConfig: AppRoute.router,
      ),
    );
  }
}
