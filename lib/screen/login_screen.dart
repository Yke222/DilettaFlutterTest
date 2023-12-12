import 'package:diletta_flutter_test/util/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen
({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
const Text('login'),
        ElevatedButton(
            onPressed: () {
              GoRouter.of(context).push(Uri(path: RoutePaths.products).toString());
            },
            child: const Text('products Page')),
    ],);
  }
}