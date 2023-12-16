import 'dart:async';

import 'package:diletta_flutter_test/core/local_storage_wishlist.dart';
import 'package:diletta_flutter_test/core/products_use_case.dart';
import 'package:diletta_flutter_test/repository/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/products_model.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository _productRepository;
  final List<ProductModel> productsWishList = [];
  final productsController = StreamController<List<ProductModel>>.broadcast();
  final wishListProductsController =
      StreamController<List<ProductModel>>.broadcast();

  ProductsBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(LoadingProductScreenState()) {
    on<InitializeProducts>((event, emit) async {
      final List<ProductModel> productsList =
          await _productRepository.getProducts();
      productsController.add(productsList);
      wishListProductsController.add([]);
      print('listLength: ${productsList.length}');
      return emit(LoadedProductScreenState(products: productsList));
    });
    on<SearchProductsByNameEvent>((event, emit) {
      final name = event.productName.toLowerCase();
      final products = event.products;
      final state = this.state;
      if (state is LoadedProductScreenState) {
        if (name.isNotEmpty) {
          final searchByName = ProductsUseCase.searchByName(products, name);
          print('searchByName: ${searchByName.length}');
          productsController.add(searchByName);
          return emit(state.copyWith(products: searchByName));
        }
      }
    });
    on<FilterByPriceEvent>((event, emit) {
      final products = event.products;
      final state = this.state;
      if (state is LoadedProductScreenState) {
        final filteredByPrice = ProductsUseCase.filterByPrice(products);
        print('price: ${filteredByPrice.first.price}');
        productsController.add(filteredByPrice);
        return emit(state.copyWith(products: List.from(filteredByPrice)));
      }
    });
    on<FilterByNameEvent>((event, emit) {
      final products = event.products;
      final state = this.state;
      if (state is LoadedProductScreenState) {
        final filteredByName = ProductsUseCase.filterByName(products);
        productsController.add(filteredByName);
        return emit(state.copyWith(products: filteredByName));
      }
    });
    on<FilterByPromotionalProductsEvent>((event, emit) {
      final products = event.products;
      final state = this.state;
      if (state is LoadedProductScreenState) {
        final filteredByPromotionalProducts =
            ProductsUseCase.filterByPromotionalProducts(products);
        productsController.add(filteredByPromotionalProducts);
        return emit(state.copyWith(products: filteredByPromotionalProducts));
      }
    });
    on<AddProductToWishlistEvent>((event, emit) {
      final product = event.productToBeAdd;
      final state = this.state;
      if (state is LoadedProductScreenState) {
        productsWishList.add(product);
        wishListProductsController.add(productsWishList);

        LocalStorageWishlist.setWishlistProduct(productsWishList);

        print(
            'onAddProductToWishlistEvent length82: ${productsWishList.length}');

        return emit(LoadedProductScreenState(
            products: LocalStorageWishlist.getPickupAnimationQueueList()));
      }
    });
  }
}

// Events
abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
  @override
  List<Object?> get props => [];
}

class InitializeProducts extends ProductsEvent {}

class InitializeWishList extends ProductsEvent {}

class SearchProductsByNameEvent extends ProductsEvent {
  final String productName;
  final List<ProductModel> products;

  const SearchProductsByNameEvent(
      {required this.productName, required this.products});
}

class FilterByPriceEvent extends ProductsEvent {
  final List<ProductModel> products;
  const FilterByPriceEvent({required this.products});
}

class FilterByNameEvent extends ProductsEvent {
  final List<ProductModel> products;
  const FilterByNameEvent({required this.products});
}

class FilterByPromotionalProductsEvent extends ProductsEvent {
  final List<ProductModel> products;
  const FilterByPromotionalProductsEvent({required this.products});
}

class AddProductToWishlistEvent extends ProductsEvent {
  final ProductModel productToBeAdd;
  const AddProductToWishlistEvent({required this.productToBeAdd});
}

// States
abstract class ProductsState extends Equatable {
  const ProductsState();
  @override
  List<Object?> get props => [];
}

class LoadedProductScreenState extends ProductsState {
  final List<ProductModel> products;

  const LoadedProductScreenState({required this.products});

  LoadedProductScreenState copyWith({
    required final List<ProductModel>? products,
  }) {
    return LoadedProductScreenState(products: products ?? this.products);
  }
}

class LoadedWishlistScreenState extends ProductsState {}

class LoadingProductScreenState extends ProductsState {}

class SearchProductsByNameState extends ProductsState {
  final List<ProductModel> searchResults;

  const SearchProductsByNameState({required this.searchResults});
}
