import 'package:diletta_flutter_test/blocs/products_bloc.dart';
import 'package:diletta_flutter_test/component/product_tile.dart';
import 'package:diletta_flutter_test/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  final List<ProductModel> products;
  const ProductsScreen({super.key, required this.products});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

@override
void initialState() {}

class _ProductsScreenState extends State<ProductsScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        TextField(
          controller: searchController,
          onChanged: (name) {
            context.read<ProductsBloc>().add(SearchProductsByNameEvent(
                productName: name, products: widget.products));
          },
          style: const TextStyle(color: Colors.orange),
          decoration: const InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                context.read<ProductsBloc>().add(
                    FilterByPromotionalProductsEvent(
                        products: widget.products));
              },
              icon: Icon(
                Icons.local_offer,
                color: Colors.orange,
              ),
            ),
            IconButton(
                onPressed: () {
                  context
                      .read<ProductsBloc>()
                      .add(FilterByPriceEvent(products: widget.products));
                },
                icon: const Icon(
                  Icons.attach_money,
                  color: Colors.orange,
                )),
            IconButton(
                onPressed: () {
                  context
                      .read<ProductsBloc>()
                      .add(FilterByNameEvent(products: widget.products));
                },
                icon: const Icon(
                  Icons.sort_by_alpha,
                  color: Colors.orange,
                )),
          ],
        ),
        const SizedBox(height: 10),
        Flexible(
          flex: 2,
          child: StreamBuilder<List<ProductModel>>(
            initialData: widget.products,
            stream: context.read<ProductsBloc>().productsController.stream,
            builder: (context, snapshot) {
              final List<ProductModel> products =
                  snapshot.data ?? widget.products;
              return ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: products.length,
                itemBuilder: (final BuildContext context, final int index) {
                  final product = products[index];
                  return ProductTile(
                    productName: product.name,
                    productImage: product.image,
                    price: product.price,
                    isPromotional: product.isPromotional,
                    onAddToWishlist: () {
                      context.read<ProductsBloc>().add(
                          AddProductToWishlistEvent(productToBeAdd: product));
                    },
                  );
                },
                separatorBuilder: (final context, final index) =>
                    const SizedBox(height: 10),
              );
            },
          ),
        ),
      ],
    );
  }
}
