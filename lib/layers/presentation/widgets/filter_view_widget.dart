import 'package:diletta_store/core/enums/filter_enum.dart';
import 'package:diletta_store/layers/presentation/controllers/products_controller.dart';
import 'package:diletta_store/layers/presentation/widgets/filter_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class FilterViewWidget extends StatelessWidget {
  FilterViewWidget({Key? key}) : super(key: key);

  final _productsController = GetIt.I.get<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      scrollDirection: Axis.horizontal,
      child: Observer(
        builder: (context) {
          return Row(
            children: [
              const Icon(Icons.filter_alt_outlined, size: 14),
              const Text(
                "Mostrar:",
                textScaleFactor: 1,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(width: 10),
              FilterOptionWidget(
                filterFunction: _productsController.toggleFilterBySale,
                filterText: "Promoções",
                filterArgument: null,
                isActive: _productsController.filters.contains(
                  FilterOption.onlySale,
                ),
              ),
              FilterOptionWidget(
                filterFunction: _productsController.toggleFilterByWishlist,
                filterText: "Wishlist",
                filterArgument: null,
                isActive: _productsController.filters.contains(
                  FilterOption.wishlist,
                ),
              ),
              const Text(
                "|",
                textScaleFactor: 1,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(width: 10),
              FilterOptionWidget(
                filterFunction: _productsController.toggleFilterByAlphabeticalOrder,
                filterText: "A-Z",
                filterArgument: FilterOption.ascendingAlphabetical,
                isActive: _productsController.filters.contains(
                  FilterOption.ascendingAlphabetical,
                ),
              ),
              FilterOptionWidget(
                filterFunction: _productsController.toggleFilterByAlphabeticalOrder,
                filterText: "Z-A",
                filterArgument: FilterOption.descendingAlphabetical,
                isActive: _productsController.filters.contains(
                  FilterOption.descendingAlphabetical,
                ),
              ),
              FilterOptionWidget(
                filterFunction: _productsController.toggleFilterByPrice,
                filterText: "Preço ▼",
                filterArgument: FilterOption.ascendingPrice,
                isActive: _productsController.filters.contains(
                  FilterOption.ascendingPrice,
                ),
              ),
              FilterOptionWidget(
                filterFunction: _productsController.toggleFilterByPrice,
                filterText: "Preço ▲",
                filterArgument: FilterOption.descendingPrice,
                isActive: _productsController.filters.contains(
                  FilterOption.descendingPrice,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
