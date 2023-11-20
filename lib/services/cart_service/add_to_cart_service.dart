// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class CartService {
//   late Database _database;
//
//   Future<void> initializeDatabase() async {
//     final databasePath = await getDatabasesPath();
//     final path = join(databasePath, 'cart_database.db');
//
//     _database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (Database db, int version) async {
//         await db.execute(
//           'CREATE TABLE cart_items(id INTEGER PRIMARY KEY, title TEXT, price REAL)',
//         );
//       },
//     );
//   }
//
//   Future<void> addToCart(String title, double price) async {
//     await _database.insert(
//       'cart_items',
//       {'title': title, 'price': price},
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   Future<void> removeFromCart(int id) async {
//     await _database.delete(
//       'cart_items',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//
//   Future<List<Map<String, dynamic>>> getCartItems() async {
//     return await _database.query('cart_items');
//   }
//
//   Future<void> updateCartItem(int id, String title, double price) async {
//     await _database.update(
//       'cart_items',
//       {'title': title, 'price': price},
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//
//   Future<void> closeDatabase() async {
//     await _database.close();
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:shop_app/model/product_model.dart';

import '../../model/cart_model.dart';

class Provider extends InheritedWidget {
  final CartController cartController = CartController();

  Provider({super.key, required super.child});

  @override
  bool updateShouldNotify(Provider oldWidget) {
    return oldWidget.cartController._cart.items != cartController._cart.items;
  }

  static CartController of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<Provider>()!.cartController;
  }
}

class CartController with ChangeNotifier {
  Cart _cart = Cart(id: 1, items: []);

  void addToCart({required ProductModel product, required int quantity}) {
    final isExist = _cart.items.any((element) => element.id == product.id);
    if (isExist) {
      final item =
          _cart.items.firstWhere((element) => element.id == product.id);
      if (quantity == 1) {
        item.quantity++;
      } else if (quantity == -1 && item.quantity > 0) {
        item.quantity--;
      }

      item.total = item.quantity * item.product.price.toDouble();
      if (item.quantity == 0) {
        _cart.items.remove(item);
      }
    } else if (quantity == 1) {
      final cartItem = CartItem(id: product.id, product: product);
      _cart.items.add(cartItem);
    }
    _cart = _cart.copyWith(items: _cart.items);
    notifyListeners();
  }

  Cart get cart => _cart;
}
