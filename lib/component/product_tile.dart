import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductTile extends StatelessWidget {
  final String productName;
  final String productImage;
  final double price;
  final bool isPromotional;
  final VoidCallback? onAddToWishlist;
  const ProductTile(
      {super.key,
      required this.productName,
      required this.productImage,
      required this.price,
      required this.isPromotional,
      this.onAddToWishlist,
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
          children: [
            Text(
              'R\$ $price',
              style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(width: 40),
            if(isPromotional) const Icon(Icons.local_offer, color: Colors.orange,),

          ],
        ),
        onTap: onAddToWishlist,
    );
  }
}
