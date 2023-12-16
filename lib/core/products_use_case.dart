import '../models/products_model.dart';

class ProductsUseCase {
  static List<ProductModel> searchByName(
      final List<ProductModel> products, final String name) {
    return products
        .where((product) => product.name.toLowerCase().contains(name))
        .toList();
  }

  static  List<ProductModel> filterByPrice(List<ProductModel> products) {
    List<ProductModel> sortedProducts = List.from(products);
    sortedProducts.sort((a, b) => a.price.compareTo(b.price));
    return sortedProducts;
  }

  static  List<ProductModel> filterByName(List<ProductModel> products) {
    List<ProductModel> sortedProducts = List.from(products);
    sortedProducts.sort((a, b) => a.name.compareTo(b.name));
    return sortedProducts;
  }

  static  List<ProductModel> filterByPromotionalProducts(List<ProductModel> products) {
    return products
        .where((product) => product.isPromotional)
        .toList();
  }
}
