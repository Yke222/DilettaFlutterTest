import 'package:ecommerce/data/models/product.dart';
import 'package:ecommerce/domain/cart_repository.dart';
import 'package:ecommerce/domain/product_repository.dart';
import 'package:ecommerce/domain/wishlist_repository.dart';
import 'package:ecommerce/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';

class ListBloc extends Cubit<ListState> {
  ListBloc(this.productRepository, this.cartRepository, this.wishlistRepository) : super(ListState());

  final ProductRepository productRepository;
  final CartRepository cartRepository;
  final WishlistRepository wishlistRepository;

  final int perPage = 19;

  void toggleViewMode() {
    emit(state.copyWith(
      viewMode: state.viewMode == PageViewMode.grid ? PageViewMode.list : PageViewMode.grid,
    ));
  }

  void setViewMode({required PageViewMode pageViewMode}) {
    emit(state.copyWith(viewMode: pageViewMode));
  }

  double getProductsTotal() {
    double total = 0;

    if (state.products != null) {
      total = state.products!.fold(0, (acc, product) => acc + product.price);
    }

    return total;
  }

  void setUser({required String userIdentifier}) {
    emit(state.copyWith(userIdentifier: userIdentifier));
  }

  void setTerm({String term = ''}) {
    emit(state.copyWith(term: term, products: []));
  }

  void setFilter({FilterMode filterMode = FilterMode.none}) {
    emit(state.copyWith(filterMode: filterMode, products: []));
  }

  Future<void> getProducts({
    required ListMode listMode,
  }) async {
    final Result<List<Product>, Exception> result;

    switch (listMode) {
      case ListMode.cart:
        result = await cartRepository.getCart();
        break;
      case ListMode.wishlist:
        result = await wishlistRepository.getWishlist();
        break;
      default:
        if ((state.products?.length ?? 0) != 0) {
          emit(state.copyWith(infiniteLoading: true));
        } else {
          emit(state.copyWith(state: PageState.loading));
        }

        result = await productRepository.getProducts(
          term: state.term,
          from: state.products?.length ?? 0,
          to: (state.products?.length ?? 0) + perPage,
          filter: state.filterMode,
        );
        break;
    }

    result.fold(
      (success) => emit(state.copyWith(
        products: listMode == ListMode.home ? [...(state.products ?? []), ...success] : [...success],
        state: PageState.success,
        infiniteLoading: false,
      )),
      (error) => state.copyWith(state: PageState.error),
    );
  }

  // Wishlist
  bool isInWishlist({required Product product}) {
    return state.wishlistProducts?.any((element) => element.id == product.id) ?? false;
  }

  Future<void> updateWishList() async {
    final result = await wishlistRepository.getWishlist();

    result.fold(
      (success) => emit(state.copyWith(wishlistProducts: success)),
      (error) => state.copyWith(state: PageState.error),
    );
  }

  Future<void> toggleWishlist({required Product product, required ListMode listMode}) async {
    if (isInWishlist(product: product)) {
      await _removeFromWishlist(product: product);
      if (listMode != ListMode.home) await getProducts(listMode: listMode);
    } else {
      await _addToWishlist(product: product);
      if (listMode != ListMode.home) await getProducts(listMode: listMode);
    }
  }

  Future<void> _addToWishlist({required Product product}) async {
    final result = await wishlistRepository.addToWishlist(product: product);
    if (result.isSuccess()) await updateWishList();
  }

  Future<void> _removeFromWishlist({required Product product}) async {
    final result = await wishlistRepository.removeFromWishlist(product: product);
    if (result.isSuccess()) await updateWishList();
  }

  //Cart

  bool isInCart({required Product product}) {
    return state.cartProducts?.any((element) => element.id == product.id) ?? false;
  }

  Future<void> updateCartList() async {
    final result = await cartRepository.getCart();

    result.fold(
      (success) => emit(state.copyWith(cartProducts: success)),
      (error) => state.copyWith(state: PageState.error),
    );
  }

  Future<void> toggleCart({required Product product, required ListMode listMode}) async {
    if (isInCart(product: product)) {
      await _removeFromCart(product: product);
      if (listMode != ListMode.home) await getProducts(listMode: listMode);
    } else {
      await _addToCart(product: product);
      if (listMode != ListMode.home) await getProducts(listMode: listMode);
    }
  }

  Future<void> _addToCart({required Product product}) async {
    final result = await cartRepository.addToCart(product: product);
    if (result.isSuccess()) await updateCartList();
  }

  Future<void> _removeFromCart({required Product product}) async {
    final result = await cartRepository.removeFromCart(product: product);
    if (result.isSuccess()) await updateCartList();
  }
}

class ListState {
  PageState? state;
  PageViewMode viewMode;
  FilterMode filterMode;
  List<Product>? products;
  List<Product>? wishlistProducts;
  List<Product>? cartProducts;
  String? userIdentifier;
  bool infiniteLoading;
  String term;

  ListState({
    this.state = PageState.idle,
    this.viewMode = PageViewMode.grid,
    this.filterMode = FilterMode.none,
    this.products,
    this.wishlistProducts,
    this.cartProducts,
    this.userIdentifier,
    this.infiniteLoading = false,
    this.term = '',
  });

  ListState copyWith({
    PageState? state,
    PageViewMode? viewMode,
    FilterMode? filterMode,
    List<Product>? products,
    List<Product>? wishlistProducts,
    List<Product>? cartProducts,
    String? userIdentifier,
    bool? infiniteLoading,
    String? term,
  }) {
    return ListState(
      state: state ?? this.state,
      viewMode: viewMode ?? this.viewMode,
      products: products ?? this.products,
      wishlistProducts: wishlistProducts ?? this.wishlistProducts,
      cartProducts: cartProducts ?? this.cartProducts,
      userIdentifier: userIdentifier ?? this.userIdentifier,
      infiniteLoading: infiniteLoading ?? this.infiniteLoading,
      term: term ?? this.term,
      filterMode: filterMode ?? this.filterMode,
    );
  }
}
