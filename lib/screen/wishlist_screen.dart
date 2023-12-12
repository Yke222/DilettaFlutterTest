import 'package:diletta_flutter_test/util/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen
({super.key});

  @override
  Widget build(BuildContext context) {
        return Column(
      children: [
const Text('login'),
        ElevatedButton(
            onPressed: () {
              GoRouter.of(context).push(Uri(path: RoutePaths.login).toString());
            },
            child: const Text('login Page')),
    ],);;
  }
}