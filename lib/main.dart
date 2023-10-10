import 'package:flutter/material.dart';
import 'package:shample_app/src/config/router/go_router.dart';
import 'package:shample_app/src/config/themes/custom_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: ConfigRouter().router,
      theme: CustomTheme.themeData  
    );
  }
}
