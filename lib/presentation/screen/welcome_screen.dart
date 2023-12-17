import 'package:diletta_flutter_test/presentation/blocs/sign_in_bloc.dart';
import 'package:diletta_flutter_test/data/repository/firebase_repository.dart';
import 'package:diletta_flutter_test/presentation/screen/products_screen.dart';
import 'package:diletta_flutter_test/presentation/screen/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../blocs/products_bloc.dart';
import '../../data/repository/product_repository.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: BlocProvider<SignInBloc>(
          create: (final context) =>
              SignInBloc(userRepository: GetIt.I<FirebaseRepository>()),
          child: BlocBuilder<SignInBloc, SignInState>(
              builder: (final BuildContext context, final SignInState state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bem vindo ao Diletta Teste App',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
                IconButton(
                    onPressed: () {
                      context
                          .read<SignInBloc>()
                          .add(const SignOutRequiredEvent());
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.orange,
                    ))
              ],
            );
          }),
        ),
      ),
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            TabBar(
              controller: tabController,
              labelColor: Colors.orange,
              tabs: const [
                Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Produtos',
                      style: TextStyle(fontSize: 18),
                    )),
                Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Favoritos',
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
            Expanded(
                // verify
                child: BlocProvider<ProductsBloc>(
                    create: (final context) => ProductsBloc(
                        productRepository: GetIt.I<ProductRepository>())
                      ..add(InitializeProducts()),
                    child: BlocBuilder<ProductsBloc, ProductsState>(builder:
                        (final BuildContext context,
                            final ProductsState state) {
                      if (state is LoadedProductScreenState) {
                        return TabBarView(
                          controller: tabController,
                          children: [
                            ProductsScreen(
                              products: state.products,
                            ),
                            const WishlistScreen(),
                          ],
                        );
                      }
                      return const Center(
                          child:
                              CircularProgressIndicator(color: Colors.orange));
                    }))),
          ]),
        ),
      ),
    );
  }
}
