import 'package:diletta_store/layers/data/datasources/local/wishlist_datasource/wishlist_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistDataSourceImp implements WishlistDataSource {
  @override
  Future<List<int>> getWishlist() async {
    final prefs = await SharedPreferences.getInstance();

    final wishlist = prefs.getStringList("wishlist") ?? [];
    final parsedWishlist = wishlist.map((id) => int.parse(id)).toList();

    return parsedWishlist;
  }

  @override
  Future<bool> addProductToWishList(int id) async {
    final prefs = await SharedPreferences.getInstance();

    final wishlist = prefs.getStringList("wishlist") ?? [];
    wishlist.add(id.toString());

    return await prefs.setStringList("wishlist", wishlist);
  }

  @override
  Future<bool> removeProductFromWishList(int id) async {
    final prefs = await SharedPreferences.getInstance();

    final wishlist = prefs.getStringList("wishlist") ?? [];
    wishlist.remove(id.toString());

    return await prefs.setStringList("wishlist", wishlist);
  }

  @override
  Future<bool> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}