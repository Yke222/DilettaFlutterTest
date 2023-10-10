import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shample_app/src/presentation/views/home/home_page.dart';
import 'package:shample_app/src/presentation/views/signin/signin_page.dart';

class ConfigRouter {
  final router = GoRouter(initialLocation: '/', routes: [
    GoRoute(
      name: 'signIn',
      path: '/',
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      name: 'homePage',
      path: '/homepage',
      builder: (context, state) => const HomePage(),
    ),
  ]);
}
