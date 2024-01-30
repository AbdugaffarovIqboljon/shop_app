import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/model/product_model.dart';

class LocalDatabase {
  saveData(ProductModel product) async {
    final List<String> list = List.from([jsonEncode(product.toJson())]);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list1 = prefs.getStringList('item') ?? [];
    for (var element in list) {
      list1.add(element);
    }
    prefs.setStringList('item', list1);
  }

  Future<List<ProductModel>> getSavedItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> list = prefs.getStringList('item') ?? <String>[];
    if (list.isNotEmpty) {
      List<ProductModel> listAll =
          list.map((e) => ProductModel.fromJson(jsonDecode(e))).toList();

      return listAll;
    } else {
      return <ProductModel>[];
    }
  }

  void removeItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void saveLikedProducts(List<ProductModel> likedProducts) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> likedProductsJson =
        likedProducts.map((product) => jsonEncode(product.toJson())).toList();
    prefs.setStringList('likedProducts', likedProductsJson);
  }

  Future<List<ProductModel>> getLikedProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> likedProductsJson =
        prefs.getStringList('likedProducts') ?? <String>[];
    if (likedProductsJson.isNotEmpty) {
      List<ProductModel> likedProducts = likedProductsJson
          .map((json) => ProductModel.fromJson(jsonDecode(json)))
          .toList();

      return likedProducts;
    } else {
      return <ProductModel>[];
    }
  }

  void removeLikedProduct(ProductModel product) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> likedProductsJson =
        prefs.getStringList('likedProducts') ?? <String>[];

    likedProductsJson.removeWhere(
      (json) => ProductModel.fromJson(jsonDecode(json)).id == product.id,
    );

    prefs.setStringList('likedProducts', likedProductsJson);
  }
}
