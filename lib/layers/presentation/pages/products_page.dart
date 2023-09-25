import 'package:diletta_store/core/enums/filter_enum.dart';
import 'package:diletta_store/layers/presentation/controllers/products_controller.dart';
import 'package:diletta_store/layers/presentation/utils/show_error_snackbar.dart';
import 'package:diletta_store/layers/presentation/widgets/custom_app_bar_widget.dart';
import 'package:diletta_store/layers/presentation/widgets/filter_view_widget.dart';
import 'package:diletta_store/layers/presentation/widgets/product_widget.dart';
import 'package:diletta_store/layers/presentation/widgets/wishlist_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _productsController = GetIt.I.get<ProductsController>();
  late final ReactionDisposer errorReactionDisposer;

  @override
  void initState() {
    super.initState();
    _productsController.getProducts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    errorReactionDisposer = reaction(
      (_) => _productsController.errorMessage,
      (errorMessage) {
        if (errorMessage != null) {
          showErrorSnackBar(context, errorMessage);
          _productsController.setErrorMessage(null);
        }
      },
    );
  }

  @override
  void dispose() {
    errorReactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBarWidget(),
        ),
        body: CustomScrollView(
          slivers: [
            // Filter options
            SliverAppBar(
              floating: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              elevation: 0.0,
              centerTitle: true,
              titleSpacing: 0,
              toolbarHeight: 40,
              title: Align(
                alignment: Alignment.centerLeft,
                child: FilterViewWidget(),
              ),
            ),

            // Products list
            Observer(
              builder: (context) {
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 190,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ProductWidget(
                        product: _productsController.products[index],
                      );
                    },
                    childCount: _productsController.products.length,
                  ),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: Observer(
          builder: (context) {
            return SizedBox(
              child: _productsController.filters.contains(FilterOption.wishlist)
                  ? WishlistSummaryWidget(
                      productsQuantity: _productsController.productsQuantity(),
                      totalPrice: _productsController.totalProductsPrice(),
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }
}
