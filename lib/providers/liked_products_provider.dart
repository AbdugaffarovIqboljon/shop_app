import 'package:flutter/material.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/data/services/database/product_database.dart';

class LikedProductsProvider extends ChangeNotifier {
  List<ProductModel> likedProducts = [];
  LocalDatabase localDatabase = LocalDatabase();

  LikedProductsProvider() {
    localDatabase.getLikedProducts().then((products) {
      likedProducts = products;
      notifyListeners();
    });
  }

  void toggleLike(ProductModel product) {
    if (likedProducts.contains(product)) {
      likedProducts.remove(product);
      localDatabase.removeLikedProduct(product);
    } else {
      likedProducts.add(product);
      localDatabase.saveLikedProducts(likedProducts);
    }

    notifyListeners();
  }
}
