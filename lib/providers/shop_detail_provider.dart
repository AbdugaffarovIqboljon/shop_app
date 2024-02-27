import 'package:flutter/foundation.dart';

import '../data/network_service.dart';
import '../model/product_model.dart';
import '../data/services/database/product_database.dart';

class ShopDetailProvider extends ChangeNotifier {
  final NetworkService productService = NetworkService();
  final LocalDatabase localDatabase = LocalDatabase();

  ProductModel? _product;
  int _quantity = 0;

  Future<ProductModel> loadProductDetails(int productId) async {
    try {
      _product =
          await productService.methodGetProductById(productId: productId);
      notifyListeners();
      return _product!;
    } catch (e) {
      debugPrint('Error fetching product details :(');
      rethrow;
    }
  }

  void updateQuantity(int newQuantity) {
    _quantity = newQuantity;
    notifyListeners();
  }

  void addToCart() {
    localDatabase.saveData(
      product: product,
      quantity: _quantity == 0 ? 1 : _quantity,
    );
    _quantity = 0;
    notifyListeners();
  }

  ProductModel get product => _product!;

  double get productPrice => _product?.price.toDouble() ?? 0.0;

  int get quantity => _quantity;
}
