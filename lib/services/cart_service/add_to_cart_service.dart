import 'package:flutter/cupertino.dart';
import 'package:shop_app/model/product_model.dart';

import '../../model/cart_model.dart';
import '../product_service.dart';

class MyProvider extends InheritedWidget {
  final CartController cartController = CartController();

  MyProvider({super.key, required super.child});

  @override
  bool updateShouldNotify(MyProvider oldWidget) {
    return oldWidget.cartController._cart.items != cartController._cart.items;
  }

  static CartController of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<MyProvider>()!.cartController;
  }
}

class CartController with ChangeNotifier {
  Cart _cart = Cart(id: 1, items: []);

  final ProductDatabase _productDatabase = ProductDatabase();

  CartController() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    await _productDatabase.open();
  }

  void addToCart({required ProductModel product, required int quantity}) async {
    final isExist = _cart.items.any((element) => element.id == product.id);

    if (isExist) {
      final item = _cart.items.firstWhere((element) => element.id == product.id);

      if (quantity == 1) {
        item.quantity++;
      } else if (quantity == -1 && item.quantity > 0) {
        item.quantity--;
      }

      item.total = item.quantity * item.product.price.toDouble();

      if (item.quantity == 0) {
        _cart.items.remove(item);
        await _productDatabase.removeProduct(product.id);
      } else {
        await _productDatabase.updateProductQuantity(
          productId: product.id,
          quantity: quantity,
        );
      }
    } else if (quantity == 1) {
      final cartItem = CartItem(id: product.id, product: product, quantity: 1);
      _cart.items.add(cartItem);
      await _productDatabase.insertProduct(product);
    }

    _cart = _cart.copyWith(items: _cart.items);
    notifyListeners();
  }


  Cart get cart => _cart;
}
