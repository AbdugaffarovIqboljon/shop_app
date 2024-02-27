import 'package:shop_app/library.dart';

class LocalDatabase {
  /// #Saved Products
  Future<void> saveData({
    required ProductModel product,
    required int quantity,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> savedItems = prefs
            .getStringList('item')
            ?.map((json) => jsonDecode(json))
            .cast<Map<String, dynamic>>()
            .toList() ??
        [];

    int existingIndex =
        savedItems.indexWhere((item) => item['id'] == product.id);

    if (existingIndex != -1) {
      savedItems[existingIndex]['quantity'] += quantity;
    } else {
      savedItems.add({
        ...product.toJson(),
        'quantity': quantity,
      });
    }

    prefs.setStringList(
      'item',
      savedItems.map((item) => jsonEncode(item)).toList(),
    );
  }

  /// #GET Product Quantity
  Future<int> getProductQuantity(int productId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> savedItems = prefs
            .getStringList('item')
            ?.map((json) => jsonDecode(json))
            .cast<Map<String, dynamic>>()
            .toList() ??
        [];

    int existingIndex =
        savedItems.indexWhere((item) => item['id'] == productId);

    return existingIndex != -1 ? savedItems[existingIndex]['quantity'] ?? 0 : 0;
  }

  Future<List<ProductModel>> getSavedItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> savedItems = prefs
            .getStringList('item')
            ?.map((json) => jsonDecode(json))
            .cast<Map<String, dynamic>>()
            .toList() ??
        [];

    List<ProductModel> products =
        savedItems.map((item) => ProductModel.fromJson(item)).toList();

    return products;
  }

  void removeItem(ProductModel product) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemsJson = prefs.getStringList('item') ?? <String>[];

    itemsJson.removeWhere(
      (json) => ProductModel.fromJson(jsonDecode(json)).id == product.id,
    );

    prefs.setStringList('item', itemsJson);
  }

  /// #Liked Products
  Future<void> saveLikedProducts(List<ProductModel> likedProducts) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList(
      'likedProducts',
      likedProducts.map((product) => jsonEncode(product.toJson())).toList(),
    );
  }

  Future<List<ProductModel>> getLikedProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> likedProductsJson = prefs.getStringList('likedProducts') ?? [];

    List<ProductModel> likedProducts = likedProductsJson
        .map((json) => ProductModel.fromJson(jsonDecode(json)))
        .toList();

    return likedProducts;
  }

  void removeLikedProduct(ProductModel product) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> likedProductsJson = prefs.getStringList('likedProducts') ?? [];

    likedProductsJson.removeWhere(
        (json) => ProductModel.fromJson(jsonDecode(json)).id == product.id);

    prefs.setStringList('likedProducts', likedProductsJson);
  }
}
