import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String productName;
  final String productImage;
  final double price;
  final bool isPromotional;
  final VoidCallback? onPressed;
  final String labelWishList;
  const ProductTile({
    super.key,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.isPromotional,
    required this.labelWishList,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(productImage),
      ),
      title: Text(
        productName,
        style: const TextStyle(
            color: Colors.orange, fontSize: 15, fontWeight: FontWeight.w400),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 100,
          child: Row(
            children: [
              Text(
                'R\$ $price',
                style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(width: 30),
              if (isPromotional)
                const Icon(
                  Icons.local_offer,
                  color: Colors.orange,
                ),
            ],
          ),
          ),

          ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
            ),
            child: Text(labelWishList),
          ),
        ],
      ),
      onTap: onPressed,
    );
  }
}
