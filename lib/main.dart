import 'package:diletta_flutter_test/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'util/products_app_route_builder.dart';

void main() {
  runApp(const MyApp());
}
Future<void> setup() async {
  DependencyInjection();
  //Bloc.observer = const BlocObserver();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerDelegate: routes.routerDelegate,
        routeInformationParser: routes.routeInformationParser,
        routeInformationProvider: routes.routeInformationProvider,
    );
  }
}
