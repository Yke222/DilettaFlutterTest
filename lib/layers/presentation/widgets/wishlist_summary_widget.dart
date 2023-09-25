import 'package:flutter/material.dart';

class WishlistSummaryWidget extends StatelessWidget {
  const WishlistSummaryWidget({
    Key? key,
    required this.productsQuantity,
    required this.totalPrice,
  }) : super(key: key);

  final int productsQuantity;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$productsQuantity",
            textScaleFactor: 1,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const Text(" Produto(s)  |  Total de ", textScaleFactor: 1),
          Text(
            "R\$${totalPrice.toStringAsFixed(2)}",
            textScaleFactor: 1,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
