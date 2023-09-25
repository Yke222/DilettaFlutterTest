import 'package:diletta_store/layers/domain/entities/product_entity.dart';
import 'package:diletta_store/layers/presentation/controllers/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductWidget extends StatelessWidget {
  final ProductEntity product;

  ProductWidget({Key? key, required this.product}) : super(key: key);

  final _productsController = GetIt.I.get<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: product.imageUrl,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: InkWell(
                  onTap: () {
                    _productsController.toggleFavoriteStatus(product);
                  },
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white.withAlpha(220),
                    child: Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 20,
                      color: product.isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
              if (product.isSale)
                Positioned(
                  right: 6,
                  top: 40,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white.withAlpha(230),
                    child: const Icon(
                      Icons.money_off,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 10,
              top: 10,
              bottom: 13,
            ),
            child: Text(
              product.title,
              textScaleFactor: 1,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.5,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "R\$${product.price.toStringAsFixed(2)}",
                  textScaleFactor: 1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                if (product.isSale)
                  Text(
                    "R\$${(product.price + product.price * (product.discount / 100)).toStringAsFixed(2)}",
                    textScaleFactor: 1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
