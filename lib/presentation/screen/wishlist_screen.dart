import 'package:diletta_flutter_test/presentation/blocs/products_bloc.dart';
import 'package:diletta_flutter_test/domain/core/local_storage_wishlist.dart';
import 'package:diletta_flutter_test/domain/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../component/product_tile.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProductModel>>(
      initialData: LocalStorageWishlist.getPickupAnimationQueueList(),
      stream: context.read<ProductsBloc>().wishListProductsController.stream,
      builder: (context, snapshot) {
        final List<ProductModel> listProducts =
            snapshot.data ?? LocalStorageWishlist.getPickupAnimationQueueList();
        return ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: listProducts.length,
          itemBuilder: (final BuildContext context, final int index) {
            final product = listProducts[index];
            return ProductTile(
              productName: product.name,
              productImage: product.image,
              price: product.price,
              isPromotional: product.isPromotional,
              labelWishList: 'Desfavoritar',
              onPressed: () {
                context.read<ProductsBloc>().add(RemoveProductFromWishlistEvent(
                    productToBeRemoved: product));
              },
            );
          },
          separatorBuilder: (final context, final index) =>
              const SizedBox(height: 10),
        );
      },
    );
  }
}
