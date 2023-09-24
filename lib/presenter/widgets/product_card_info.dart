import 'package:ecommerce/app_colors.dart';
import 'package:ecommerce/data/models/product.dart';
import 'package:flutter/material.dart';

class ProductCardInfo extends StatelessWidget {
  const ProductCardInfo({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Text(
          product.name,
          maxLines: 1,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "R\$ ${product.price.toStringAsFixed(2)}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.gray700),
            ),
            const SizedBox(width: 5),
            Visibility(
              visible: product.oldPrice > product.price,
              child: Text(
                "R\$ ${product.oldPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.gray700,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
