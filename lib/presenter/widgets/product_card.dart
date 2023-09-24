import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app_colors.dart';
import 'package:ecommerce/data/models/product.dart';
import 'package:ecommerce/presenter/widgets/custom_button.dart';
import 'package:ecommerce/presenter/widgets/product_card_info.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    this.isGrid = false,
    this.isWishlist = false,
    this.isPurchase = false,
    this.onWishlist,
    this.onPurchase,
  }) : super(key: key);

  final Product product;
  final bool isGrid;
  final bool isWishlist;
  final bool isPurchase;
  final Function()? onWishlist;
  final Function()? onPurchase;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 1,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: isGrid ? columnCard(context) : rowCard(context),
      ),
    );
  }

  Widget columnCard(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl: product.image,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(child: ProductCardInfo(product: product)),
              const SizedBox(height: 12),
              _purchaseButton(),
            ],
          ),
          Positioned(
            right: 0,
            child: _favoriteButton(),
          ),
          Positioned(
            left: 0,
            child: _discountBadge(),
          ),
        ],
      ),
    );
  }

  Widget rowCard(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CachedNetworkImage(
                imageUrl: product.image,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ProductCardInfo(product: product),
            ),
            _discountBadge(),
            _favoriteButton(),
          ],
        ),
        const SizedBox(height: 12),
        _purchaseButton(),
      ],
    );
  }

  Widget _discountBadge() {
    double discount = product.oldPrice - product.price;
    double discountPercent = (discount / product.oldPrice) * 100;

    if (discountPercent <= 0) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(8),
      child: Text(
        '${discountPercent.toStringAsFixed(0)}%',
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
      ),
    );
  }

  Widget _purchaseButton() {
    return CustomButton(
      onPressed: onPurchase,
      hierarchy: isPurchase ? CustomButtonHierarchy.gray : CustomButtonHierarchy.primary,
      title: isPurchase ? 'No carrinho' : 'Comprar',
      trailing: isPurchase
          ? Icon(
              Icons.shopping_cart_sharp,
              color: AppColors.gray700,
              size: 18,
            )
          : null,
    );
  }

  Widget _favoriteButton() {
    return IconButton.filledTonal(
      onPressed: onWishlist ?? () {},
      padding: const EdgeInsets.all(6),
      icon: Icon(
        isWishlist ? Icons.favorite : Icons.favorite_border,
        color: AppColors.primaryColor,
      ),
    );
  }
}
