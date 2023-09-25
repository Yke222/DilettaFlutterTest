abstract class WishlistDataSource {
  /// Gets all products from the current user's wishlist from local storage.
  Future<List<int>> getWishlist();

  /// Adds a product id to the locally stored wishlist.
  Future<bool> addProductToWishList(int id);

  /// Remove a product from the locally stored wish list.
  Future<bool> removeProductFromWishList(int id);

  /// Removes all data stored on internal storage.
  Future<bool> clearData();
}