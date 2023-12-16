import 'package:diletta_flutter_test/models/products_model.dart';
import 'package:shared_preferences/shared_preferences.dart' as sp;

class LocalStorageWishlist{
  static sp.SharedPreferences? _preferences;

    static Future<void> setup({final sp.SharedPreferences? instance}) async {
    _preferences = instance ?? await sp.SharedPreferences.getInstance();
  }

  static const String _wishList = 'wishlist';

  static Future<void> setWishlistProduct(final List<ProductModel> list) async {
    final String encodedList = ProductModel.encode(list);

    final _ = _preferences?.setString(_wishList, encodedList);
  }

  static List<ProductModel> getPickupAnimationQueueList() {
    final String jsonString = _preferences?.getString(_wishList) ?? '[]';

    return ProductModel.decode(jsonString);
  }

}