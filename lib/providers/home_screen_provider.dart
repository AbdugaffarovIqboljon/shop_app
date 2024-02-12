import 'package:flutter/foundation.dart';

import '../data/network_service.dart';
import '../model/product_model.dart';

class HomeScreenProvider extends ChangeNotifier {
  final NetworkService productService = NetworkService();
  List<ProductModel> _productList = [];

  List<ProductModel> get productList => _productList;

  Future<void> initializeData() async {
    await fetchAllData();
  }

  Future<void> fetchAllData() async {
    try {
      List<ProductModel> fetchedProducts =
          await productService.methodGetAllProducts();
      setProductList(fetchedProducts);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchProductsByCategory(String category) async {
    try {
      setProductList([]);
      List<ProductModel> fetchedProducts =
          await productService.methodGetProductsByCategory(category: category);
      setProductList(fetchedProducts);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void setProductList(List<ProductModel> products) {
    _productList = products;
    notifyListeners();
  }
}
