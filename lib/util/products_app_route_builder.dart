import 'package:diletta_flutter_test/screen/login_screen.dart';
import 'package:diletta_flutter_test/screen/products_screen.dart';
import 'package:diletta_flutter_test/screen/wishlist_screen.dart';
import 'package:diletta_flutter_test/util/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: RoutePaths.login,

  routes: [
    GoRoute(
      name: 'login',
      path: RoutePaths.login,
      pageBuilder: (context, state) {
        return const MaterialPage(child: LoginScreen());
      },
    ),
    GoRoute(
      name: 'products',
      path: RoutePaths.products,
      pageBuilder: (context, state) {
        return const MaterialPage(child: ProductsScreen());
      },
    ),
    GoRoute(
      name: 'wishlist',
      path: RoutePaths.wishlist,
      pageBuilder: (context, state) {
        return const MaterialPage(child: WishlistScreen());
      },
    ),
  ],
);
