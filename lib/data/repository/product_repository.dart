import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../domain/models/products_model.dart';
import '../service/environment_config.dart';

class ProductRepository {
  Future<List<ProductModel>> getProducts() async {
    http.Response response =
        await http.get(Uri.parse('${EnvironmentConfig.endpointName}/products'));

        if(response.statusCode ==200){
          final List<dynamic> jsonList = json.decode(response.body);

      List<ProductModel> products = jsonList
          .map((json) => ProductModel.fromJson(json))
          .toList();
          return products;
        }
    return json.decode(response.body);
  }
}
