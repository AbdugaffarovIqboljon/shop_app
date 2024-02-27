import 'package:flutter/foundation.dart';

import '../model/product_model.dart';
import '../data/services/database/product_database.dart';

class CartProvider extends ChangeNotifier {
  List<ProductModel> selectedProducts = [];
  LocalDatabase localDatabase = LocalDatabase();

  void toggleProductSelection({required ProductModel product}) {
    if (selectedProducts.contains(product)) {
      selectedProducts.remove(product);
    } else {
      selectedProducts.add(product);
    }
    notifyListeners();
  }

  Future<void> removeItems(ProductModel product) async {
    localDatabase.removeItem(product);
    notifyListeners();
  }
}
