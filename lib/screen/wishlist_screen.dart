import 'package:diletta_flutter_test/core/local_storage_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/products_bloc.dart';
import '../component/product_tile.dart';
import '../models/products_model.dart';

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
            );
          },
          separatorBuilder: (final context, final index) =>
              const SizedBox(height: 10),
        );
      },
    );
  }
}
