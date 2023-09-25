// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductsController on _ProductsController, Store {
  late final _$errorMessageAtom =
      Atom(name: '_ProductsController.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$searchTermAtom =
      Atom(name: '_ProductsController.searchTerm', context: context);

  @override
  String? get searchTerm {
    _$searchTermAtom.reportRead();
    return super.searchTerm;
  }

  @override
  set searchTerm(String? value) {
    _$searchTermAtom.reportWrite(value, super.searchTerm, () {
      super.searchTerm = value;
    });
  }

  late final _$getProductsAsyncAction =
      AsyncAction('_ProductsController.getProducts', context: context);

  @override
  Future<void> getProducts({bool load = false}) {
    return _$getProductsAsyncAction.run(() => super.getProducts(load: load));
  }

  late final _$toggleFavoriteStatusAsyncAction =
      AsyncAction('_ProductsController.toggleFavoriteStatus', context: context);

  @override
  Future<void> toggleFavoriteStatus(ProductEntity product) {
    return _$toggleFavoriteStatusAsyncAction
        .run(() => super.toggleFavoriteStatus(product));
  }

  late final _$setSearchTermAsyncAction =
      AsyncAction('_ProductsController.setSearchTerm', context: context);

  @override
  Future<void> setSearchTerm(String? term) {
    return _$setSearchTermAsyncAction.run(() => super.setSearchTerm(term));
  }

  late final _$toggleFilterByWishlistAsyncAction = AsyncAction(
      '_ProductsController.toggleFilterByWishlist',
      context: context);

  @override
  Future<void> toggleFilterByWishlist() {
    return _$toggleFilterByWishlistAsyncAction
        .run(() => super.toggleFilterByWishlist());
  }

  late final _$toggleFilterBySaleAsyncAction =
      AsyncAction('_ProductsController.toggleFilterBySale', context: context);

  @override
  Future<void> toggleFilterBySale() {
    return _$toggleFilterBySaleAsyncAction
        .run(() => super.toggleFilterBySale());
  }

  late final _$toggleFilterByAlphabeticalOrderAsyncAction = AsyncAction(
      '_ProductsController.toggleFilterByAlphabeticalOrder',
      context: context);

  @override
  Future<void> toggleFilterByAlphabeticalOrder(FilterOption order) {
    return _$toggleFilterByAlphabeticalOrderAsyncAction
        .run(() => super.toggleFilterByAlphabeticalOrder(order));
  }

  late final _$toggleFilterByPriceAsyncAction =
      AsyncAction('_ProductsController.toggleFilterByPrice', context: context);

  @override
  Future<void> toggleFilterByPrice(FilterOption order) {
    return _$toggleFilterByPriceAsyncAction
        .run(() => super.toggleFilterByPrice(order));
  }

  late final _$_ProductsControllerActionController =
      ActionController(name: '_ProductsController', context: context);

  @override
  void addUniqueFilter(FilterOption filter) {
    final _$actionInfo = _$_ProductsControllerActionController.startAction(
        name: '_ProductsController.addUniqueFilter');
    try {
      return super.addUniqueFilter(filter);
    } finally {
      _$_ProductsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorMessage(String? message) {
    final _$actionInfo = _$_ProductsControllerActionController.startAction(
        name: '_ProductsController.setErrorMessage');
    try {
      return super.setErrorMessage(message);
    } finally {
      _$_ProductsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
searchTerm: ${searchTerm}
    ''';
  }
}
