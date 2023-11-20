import 'package:shop_app/model/product_model.dart';

class CartItem {
  final int id;
  int quantity;
  double total;
  final ProductModel product;

  CartItem({
    required this.id,
    this.quantity = 1,
    required this.product,
  }) : total = quantity * product.price.toDouble();

  @override
  String toString() {
    return "CartItem{$product - $quantity}; ";
  }

  CartItem copyWith({
    int? id,
    int? quantity,
    ProductModel? product,
  }) {
    return CartItem(
        id: id ?? this.id,
        product: product ?? this.product,
        quantity: quantity ?? this.quantity);
  }
}

class Cart {
  final int id;
  List<CartItem> items;
  double total;

  Cart({required this.id, required this.items})
      : total = items.fold<double>(
            0.0, (previousValue, element) => previousValue + element.total);

  Cart copyWith({int? id, List<CartItem>? items}) {
    return Cart(id: id ?? this.id, items: items ?? this.items);
  }

  @override
  String toString() {
    return "Cart{total: $total, items: $items}";
  }
}
