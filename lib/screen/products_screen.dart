import 'package:diletta_flutter_test/util/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen
({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
const Text('ProductScreen'),
        ElevatedButton(
            onPressed: () {
              GoRouter.of(context).push(Uri(path: RoutePaths.wishlist).toString());
            },
            child: const Text('wishlist Page')),
    ],);
  }
}