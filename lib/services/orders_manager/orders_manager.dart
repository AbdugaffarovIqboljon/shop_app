import 'package:shop_app/model/product_model.dart';

class OrdersManager {
  List<ProductModel> orderedProducts = []; // Maintain a list of ordered products

  void addToOrders(ProductModel product) {
    orderedProducts.add(product); // Add the product to orders list
  }
}
