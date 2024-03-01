import 'package:flutter/foundation.dart';

import '../data/services/database/product_database.dart';
import '../model/product_model.dart';

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

  Future<void> removeItems(List<ProductModel> selectedProducts) async {
    for (final product in selectedProducts) {
      localDatabase.removeItem(product);
    }
    selectedProducts.clear();
    notifyListeners();
  }

  Future<List<ProductModel>> getSavedItems() async {
    return await Future.delayed(const Duration(milliseconds: 380)).then(
      (value) => localDatabase.getSavedItems(),
    );
  }
}
