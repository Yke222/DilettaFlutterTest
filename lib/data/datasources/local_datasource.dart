import 'dart:convert';

import 'package:ecommerce/data/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<bool> addProductTo({required Product product, bool fromCart = true});
  Future<bool> removeProductFrom({required Product product, bool fromCart = true});
  Future<List<Product>> getProductFrom({bool fromCart = true});
}

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences db;
  final String userIdentifier;

  final cartKey = 'cart_list';
  final wishlistKey = 'wishlist_list';

  LocalDataSourceImpl({required this.userIdentifier, required this.db});

  String getUserKey({required bool fromCart}) {
    return fromCart ? '${userIdentifier}_$cartKey' : '${userIdentifier}_$wishlistKey';
  }

  @override
  Future<bool> addProductTo({required Product product, bool fromCart = true}) async {
    final key = getUserKey(fromCart: fromCart);
    List<Product> content = [];

    if (db.containsKey(key)) {
      final data = json.decode(db.getString(key) ?? '');
      content = data.map((it) => Product.fromLocalJson(json: it)).toList().cast<Product>();
    }

    content.add(product);

    return await db.setString(key, json.encode(content.map((e) => e.toJson()).toList()));
  }

  @override
  Future<bool> removeProductFrom({required Product product, bool fromCart = true}) async {
    String key = getUserKey(fromCart: fromCart);
    List<Product> content = [];

    if (!db.containsKey(key)) return false;

    final data = json.decode(db.getString(key) ?? '');
    content = data.map((it) => Product.fromLocalJson(json: it)).toList().cast<Product>();
    content.removeWhere((element) => element.id == product.id);

    return await db.setString(key, json.encode(content.map((e) => e.toJson()).toList()));
  }

  @override
  Future<List<Product>> getProductFrom({bool fromCart = true}) async {
    String key = getUserKey(fromCart: fromCart);

    if (!db.containsKey(key)) return [];

    List<Product> content = [];

    final data = json.decode(db.getString(key) ?? '');
    content = data.map((it) => Product.fromLocalJson(json: it)).toList().cast<Product>();

    return content;
  }
}
