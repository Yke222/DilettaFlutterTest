import 'package:ecommerce/app_colors.dart';
import 'package:ecommerce/data/models/product.dart';
import 'package:ecommerce/presenter/list/list_bloc.dart';
import 'package:ecommerce/presenter/widgets/custom_button.dart';
import 'package:ecommerce/presenter/widgets/empty_widget.dart';
import 'package:ecommerce/presenter/widgets/filter_modal.dart';
import 'package:ecommerce/presenter/widgets/infinite_loading_widget.dart';
import 'package:ecommerce/presenter/widgets/loading_widget.dart';
import 'package:ecommerce/presenter/widgets/product_card.dart';
import 'package:ecommerce/presenter/widgets/error_widget.dart' as error_widget;
import 'package:ecommerce/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({
    Key? key,
    required this.title,
    required this.listMode,
    required this.userIdentifier,
  }) : super(key: key);

  final String userIdentifier;
  final String title;
  final ListMode listMode;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _searchController = TextEditingController();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
  }

  ListBloc init(BuildContext context) {
    final bloc = Provider.of<ListBloc>(context);

    if (bloc.state.state == PageState.idle) {
      bloc.getProducts(listMode: widget.listMode);
      bloc.updateCartList();
      bloc.updateWishList();

      _scrollController = ScrollController();
      _searchController.clear();

      if (widget.listMode == ListMode.cart) bloc.setViewMode(pageViewMode: PageViewMode.list);
      if (widget.listMode == ListMode.home) {
        _scrollController.addListener(() {
          if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
            bloc.getProducts(listMode: widget.listMode);
          }
        });
      }
    }
    return bloc;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = init(context);

    return BlocBuilder<ListBloc, ListState>(
      bloc: bloc,
      builder: (context, value) {
        final products = bloc.state.products ?? [];
        final isGrid = bloc.state.viewMode == PageViewMode.grid;

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            actions: [
              Visibility(
                visible: widget.listMode != ListMode.cart,
                child: IconButton(
                  onPressed: bloc.toggleViewMode,
                  icon: Icon(isGrid ? Icons.list : Icons.grid_view_rounded),
                ),
              ),
              Visibility(
                visible: widget.listMode == ListMode.home,
                child: IconButton(
                  onPressed: () {
                    Utils.showModal(
                      context: context,
                      widget: FilterModal(
                        selected: bloc.state.filterMode,
                        onTap: (filter) {
                          bloc.setFilter(filterMode: filter);
                          bloc.getProducts(listMode: widget.listMode);
                        },
                      ),
                    );
                  },
                  icon: Stack(
                    children: [
                      const Icon(Icons.filter_list_alt),
                      Visibility(
                        visible: bloc.state.filterMode != FilterMode.none,
                        child: Positioned(
                          right: 0,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: AppColors.red,
                              border: Border.all(width: 2, color: AppColors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                icon: const Icon(
                  Icons.exit_to_app,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Visibility(
                visible: widget.listMode == ListMode.home,
                child: _renderFilters(bloc: bloc),
              ),
              _renderExceptions(bloc: bloc) ??
                  Expanded(
                    child: isGrid
                        ? GridView.builder(
                            controller: _scrollController,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 256,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: products.length,
                            padding: const EdgeInsets.fromLTRB(12, 12, 12, 50),
                            itemBuilder: (context, index) =>
                                _productCard(bloc: bloc, product: products[index], isGrid: true),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: products.length,
                            padding: const EdgeInsets.fromLTRB(12, 12, 12, 50),
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: _productCard(
                                bloc: bloc,
                                product: products[index],
                              ),
                            ),
                          ),
                  ),
              if (bloc.state.infiniteLoading) const InfiniteLoadingWidget(),
              if (widget.listMode == ListMode.cart && (bloc.state.products ?? []).isNotEmpty) _cartSummary(bloc: bloc),
            ],
          ),
        );
      },
    );
  }

  Widget? _renderExceptions({required ListBloc bloc}) {
    if (bloc.state.state == PageState.loading) return const Expanded(child: LoadingWidget());
    if (bloc.state.state == PageState.error) return const Expanded(child: error_widget.ErrorWidget());
    if (bloc.state.state == PageState.success && (bloc.state.products ?? []).isEmpty) {
      return const Expanded(child: EmptyWidget());
    }
    return null;
  }

  Widget _productCard({required ListBloc bloc, required Product product, bool isGrid = false}) {
    return ProductCard(
      product: product,
      isPurchase: bloc.isInCart(product: product),
      isWishlist: bloc.isInWishlist(product: product),
      isGrid: isGrid,
      onPurchase: () async {
        await bloc.toggleCart(product: product, listMode: widget.listMode);
      },
      onWishlist: () async {
        await bloc.toggleWishlist(product: product, listMode: widget.listMode);
      },
    );
  }

  Widget _cartSummary({required ListBloc bloc}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: CustomButton(
          title: 'Ir para entrega (R\$ ${bloc.getProductsTotal().toStringAsFixed(2)})', size: CustomButtonSize.xl),
    );
  }

  Widget _renderFilters({required ListBloc bloc}) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                        label: const Text('Buscar por palavra chave:'),
                        filled: true,
                        fillColor: AppColors.primaryColor.withOpacity(0.15),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: "Ex: Creatina, Whey"),
                    validator: Utils.emptyValidator,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      bloc.setTerm(term: _searchController.text);
                      bloc.getProducts(listMode: widget.listMode);
                    }
                  },
                  icon: const Icon(Icons.search),
                ),
                if (bloc.state.term.isNotEmpty)
                  Column(
                    children: [
                      const SizedBox(width: 8),
                      IconButton.filledTonal(
                        onPressed: () {
                          if (_searchController.text.isNotEmpty) {
                            _searchController.clear();
                            bloc.setTerm();
                            bloc.getProducts(listMode: widget.listMode);
                          }
                        },
                        icon: const Icon(Icons.clear),
                      )
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
