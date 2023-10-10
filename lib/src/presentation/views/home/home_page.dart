import 'package:flutter/material.dart';
import 'package:shample_app/src/presentation/cubits/blocs/product_bloc.dart';
import 'package:shample_app/src/presentation/cubits/events/produc_events.dart';
import 'package:shample_app/src/presentation/cubits/states/product_state.dart';
import 'package:shample_app/src/presentation/widgets/customnavigator/custom_navigator.dart';
import 'package:shample_app/src/presentation/widgets/productcard/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ProductBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = ProductBloc();
    bloc.add(LoadProductEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
          onItemTapped: (int value) {},
          selectedIndex: 0,
        ),
        body: StreamBuilder<ProductState>(
            stream: bloc.stream,
            builder: (context, AsyncSnapshot<ProductState> snapshot) {
              final productList = snapshot.data?.products ?? [];
              return ListView.separated(
                  itemBuilder: (context, index) => ProductCard(
                      imageUrl: productList[index].productImage,
                      name: productList[index].productName,
                      rating: 0,
                      price: double.parse(productList[index].productAmount)),
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: productList.length);
            }),
      ),
    );
  }
}
