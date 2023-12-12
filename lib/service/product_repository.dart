import 'dart:convert';

import 'package:diletta_flutter_test/service/environment_config.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<Map> getProducts() async {
http.Response response = await http.get((EnvironmentConfig.endpointName + '/products') as Uri);
return json.decode(response.body);
}
}