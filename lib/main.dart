import 'package:dio/dio.dart';
import 'package:ecommerce/app_colors.dart';
import 'package:ecommerce/data/datasources/local_datasource.dart';
import 'package:ecommerce/data/datasources/remote_datasource.dart';
import 'package:ecommerce/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce/data/repositories/product_repository_impl.dart';
import 'package:ecommerce/data/repositories/wishlist_repository_impl.dart';
import 'package:ecommerce/domain/cart_repository.dart';
import 'package:ecommerce/domain/product_repository.dart';
import 'package:ecommerce/domain/wishlist_repository.dart';
import 'package:ecommerce/presenter/list/list_bloc.dart';
import 'package:ecommerce/presenter/list/list_page.dart';
import 'package:ecommerce/presenter/login/login.dart';
import 'package:ecommerce/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Integralmedica',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ),
        fontFamily: 'Inter',
        appBarTheme: AppBarTheme(
          color: AppColors.white,
          surfaceTintColor: AppColors.white,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: AppColors.black,
          ),
        ),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginPage(),
        '/root': (context) => RootPage(userIdentifier: ModalRoute.of(context)?.settings.arguments as String),
      },
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key, required this.userIdentifier});

  final String userIdentifier;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Provider<ListBloc>.value(
      value: Factory.getListBloc(),
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          indicatorColor: AppColors.primaryColor,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home, color: AppColors.white),
              icon: const Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: const Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite, color: AppColors.white),
              label: 'Wishlist',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.shopping_cart_rounded,
                color: AppColors.white,
              ),
              icon: const Icon(Icons.shopping_cart_outlined),
              label: 'Carrinho',
            ),
          ],
        ),
        body: <Widget>[
          ListPage(
            title: 'Produtos',
            listMode: ListMode.home,
            userIdentifier: widget.userIdentifier,
          ),
          ListPage(
            title: 'Wishlist',
            listMode: ListMode.wishlist,
            userIdentifier: widget.userIdentifier,
          ),
          ListPage(
            title: 'Carrinho',
            listMode: ListMode.cart,
            userIdentifier: widget.userIdentifier,
          ),
        ][currentPageIndex],
      ),
    );
  }
}

class Factory {
  static late SharedPreferences sharedPreferences;
  static late Dio dio;

  static late LocalDataSource localDataSource;
  static late RemoteDataSource remoteDataSource;

  static late CartRepository cartRepository;
  static late ProductRepository productRepository;
  static late WishlistRepository wishlistRepository;

  static bool isInit = false;

  static Future<void> init({required String userIdentifier}) async {
    if (isInit) return;

    dio = Dio();
    sharedPreferences = await SharedPreferences.getInstance();

    localDataSource = LocalDataSourceImpl(db: sharedPreferences, userIdentifier: userIdentifier);
    remoteDataSource = RemoteDataSourceImpl(dio: dio);

    cartRepository = CartRepositoryImpl(dataSource: localDataSource);
    productRepository = ProductRepositoryImpl(dataSource: remoteDataSource);
    wishlistRepository = WishlistRepositoryImpl(dataSource: localDataSource);

    isInit = true;
  }

  static ListBloc getListBloc() {
    return ListBloc(productRepository, cartRepository, wishlistRepository);
  }
}
