import 'package:dio/dio.dart';
import 'package:shample_app/src/domain/models/product.dart';
import 'package:shample_app/src/utils/constants/api_constants.dart';

class DioProduct {
  final Dio _dio = Dio();

  Future<List<Product>> getData() async {
    try {
      final response =
          await _dio.get(ApiConstants.listBaseUrl + ApiConstants.products);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        final List<Product> products = responseData
            .map((item) => Product.fromJson(item))
            .toList();
        return products;
      } else {
        return [];
      }
    } catch (e) {
      throw e;
    }
  }
}
