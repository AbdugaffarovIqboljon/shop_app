import 'package:flutter/material.dart';
import 'package:shop_app/services/orders_manager/orders_manager.dart';

class OrdersScreen extends StatelessWidget {
  final OrdersManager ordersManager;

  const OrdersScreen({Key? key, required this.ordersManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Orders'),
      ),
      body: ListView.builder(
        itemCount: ordersManager.orderedProducts.length,
        itemBuilder: (context, index) {
          final orderedProduct = ordersManager.orderedProducts[index];
          return ListTile(
            title: Text(orderedProduct.title), // Display the ordered product details
            // Add more details or customize the ListTile as needed
          );
        },
      ),
    );
  }
}
