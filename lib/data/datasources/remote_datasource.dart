import 'package:dio/dio.dart';
import 'package:ecommerce/data/models/product.dart';
import 'package:ecommerce/utils.dart';

abstract class RemoteDataSource {
  Future<List<Product>> getProducts({
    String term = '',
    int from = 0,
    int to = 20,
    FilterMode filterMode = FilterMode.none,
  });
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final Dio dio;

  RemoteDataSourceImpl({required this.dio});

  @override
  Future<List<Product>> getProducts({
    String term = '',
    int from = 0,
    int to = 20,
    FilterMode filterMode = FilterMode.none,
  }) async {
    String url = '${Utils.baseUrl()}?_from=$from&_to=$to';

    final params = {
      FilterMode.none: '',
      FilterMode.priceAsc: 'O=OrderByPriceASC',
      FilterMode.priceDesc: 'O=OrderByPriceDESC',
      FilterMode.nameAsc: 'O=OrderByNameASC',
      FilterMode.nameDesc: 'O=OrderByNameDESC',
      FilterMode.bestDiscount: 'O=OrderByBestDiscountDESC'
    };

    url += '&${params[filterMode]}';

    if (term.isNotEmpty) {
      url += '&ft=$term';
    }

    print(url);

    final response = await dio.get(url);
    List<Product> products = [];

    if (response.statusCode == 200 || response.statusCode == 206) {
      products = (response.data as List).map((it) => Product.fromRemoteJson(json: it)).toList();
    }

    return products;
  }
}
