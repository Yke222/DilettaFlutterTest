import 'package:diletta_store/core/inject/inject.dart';
import 'package:diletta_store/layers/presentation/pages/products_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Inject.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 20, 20, 20)),
        scaffoldBackgroundColor: Colors.black.withAlpha(200),
        cardColor: const Color.fromARGB(255, 50, 50, 50),
        colorScheme: ColorScheme.dark(
          background: Colors.black.withAlpha(200),
          primary: const Color.fromARGB(255, 20, 20, 20),
          secondary: const Color.fromARGB(255, 30, 30, 30),
        )
      ),
      home: const ProductsPage(),
    ),
  );
}
