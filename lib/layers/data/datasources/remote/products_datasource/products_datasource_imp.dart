import 'dart:convert';

import 'package:diletta_store/layers/data/datasources/remote/products_datasource/products_datasource.dart';
import 'package:diletta_store/layers/data/dtos/product_dto.dart';
import 'package:http/http.dart' as http;

class ProductsDataSourceImp implements ProductsDataSource {
  @override
  Future<List<ProductDTO>> getAvailableProducts() async {
    final Uri url = Uri.parse("https://dummyjson.com/products");
    final http.Response response = await http.get(url);
    final productsJson = json.decode(response.body);

    final List<ProductDTO> products = [];
    for (Map<String, dynamic> product in productsJson["products"]) {
      products.add(ProductDTO.fromJson(product));
    }

    return products;
  }
}
