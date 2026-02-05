import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/presentation/pages/catalog_detail_screen.dart';
import 'package:myapp/presentation/pages/catalog_view.dart';
import 'package:myapp/presentation/pages/home_screen.dart';
import 'package:myapp/presentation/pages/login_screen.dart';
import 'package:myapp/presentation/pages/product_screen.dart';
import 'package:myapp/core/routes/main_screen.dart';
import 'package:myapp/presentation/pages/profile_screen.dart';
import 'package:myapp/presentation/pages/sign_up_screen.dart';

sealed class Routes {
  static String _appendToCurrentPath(String newPath) {
    final newPathUri = Uri.parse(newPath);
    final currentUri = AppRoute.router.routeInformationProvider.value.uri;
    Map<String, dynamic> params = Map.of(currentUri.queryParameters);
    params.addAll(newPathUri.queryParameters);
    Uri loc = Uri(
      path: '${currentUri.path}/${newPathUri.path}'.replaceAll('//', '/'),
      queryParameters: params,
    );
    return loc.toString();
  }

  static String _replaceToCurrentPath(String newPath, String oldPath) {
    final newUri = Uri.parse(newPath);
    final currentUri = AppRoute.router.routeInformationProvider.value.uri;
    final oldUri = Uri.parse(oldPath);
    final subUri = Uri(
      pathSegments: currentUri.pathSegments.sublist(
        0,
        currentUri.pathSegments.indexOf(oldUri.pathSegments.first),
      ),
    );

    Map<String, Object?> params = Map.of(currentUri.queryParameters);
    params.addAll(newUri.queryParameters);

    Uri loc = Uri(
      path: '/${subUri.path}/${newUri.path}'.replaceAll('//', '/'),
      queryParameters: params,
    );
    return loc.toString();
  }

  static const String home = "/home";
  static const String catalog = "/catalog";
  static const String cart = "/cart";
  static const String favorite = "/favorite";
  static const String profile = "/profile";
  static const String login = "/login";
  static const String signUp = "/sign-up";

  static const product = "product/:id";
  static String productWithId(Object id) {
    final currentUri = AppRoute.router.routeInformationProvider.value.uri;
    if (currentUri.path.contains("product")) {
      return _replaceToCurrentPath(
        "product/$id",
        currentUri.path.substring(currentUri.path.indexOf("product")),
      );
    }

    return _appendToCurrentPath('product/$id');
  }

  static const categoryDetail = "detail/:catalogID";
  static String categoryDetailWithId(Object id) => "/catalog/detail/$id";
}

final GlobalKey<NavigatorState> rootnavigationKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

sealed class AppRoute {
  static String initialRoute = Routes.signUp;

  static final _authRoutes = [
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
  ];
  static final GoRouter router = GoRouter(
    initialLocation: initialRoute,
    navigatorKey: rootnavigationKey,
    routes: [
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        parentNavigatorKey: rootnavigationKey,
        builder: (context, state, child) {
          return Main(
            key: state.pageKey,
            currentIndex: switch (state.uri.path) {
              final p when p.startsWith(Routes.home) => 0,
              final p when p.startsWith(Routes.catalog) => 1,
              final p when p.startsWith(Routes.cart) => 2,
              final p when p.startsWith(Routes.favorite) => 3,
              final p when p.startsWith(Routes.profile) => 4,
              _ => 0,
            },
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: Routes.home,
            builder: (context, state) => HomeScreen(),
            routes: [
              GoRoute(
                path: Routes.product,
                parentNavigatorKey: rootnavigationKey,
                builder: (context, state) {
                  return ProductScreen(
                    id: state.pathParameters['id']!,
                    key: ValueKey(state.pathParameters['id']!),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: Routes.catalog,
            builder: (context, state) => const CatalogScreen(),
            routes: [
              GoRoute(
                path: Routes.categoryDetail,
                parentNavigatorKey: rootnavigationKey,
                builder: (context, state) {
                  return CatalogDetailScreen(
                    catalogID: state.pathParameters['catalogID']!,
                    key: ValueKey(state.pathParameters['catalogID']!),
                  );
                },
                routes: [
                  GoRoute(
                    path: Routes.product,
                    parentNavigatorKey: rootnavigationKey,
                    builder: (context, state) {
                      return ProductScreen(
                        id: state.pathParameters['id']!,
                        key: ValueKey(state.pathParameters['id']!),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: Routes.cart,
            builder: (context, state) => const Scaffold(),
          ),
          GoRoute(
            path: Routes.favorite,
            builder: (context, state) => const Scaffold(),
          ),
          GoRoute(
            path: Routes.profile,
            builder: (context, state) => ProfileScreen(),
          ),
        ],
      ),
      ..._authRoutes,
    ],
  );
}
