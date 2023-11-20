import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/services/cart_service/add_to_cart_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ProductModel> selectedProducts = [];

  void toggleProductSelection(ProductModel product) {
    setState(() {
      if (selectedProducts.contains(product)) {
        selectedProducts.remove(product);
      } else {
        selectedProducts.add(product);
      }
    });
  }

  void showOrderConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset("assets/lotties/delivery_lottie.json"),
              SizedBox(height: 30.sp),
              Text(
                "Your order will be delivered in 1-2 days. Track your order in Orders Screen",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.sp,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                selectedProducts.clear();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Your Cart",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24.sp,
            color: const Color(0xFF212121),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: Provider.of(context).cart.items.length,
        itemBuilder: (context, index) {
          final cartItem = Provider.of(context).cart.items[index];
          final product = cartItem.product;
          final isSelected = selectedProducts.contains(product);

          return Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            child: ListTile(
              onTap: () {
                toggleProductSelection(product);
              },
              leading: Image(
                image: NetworkImage(product.image),
              ),
              title: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "Quantity: ${cartItem.quantity.toString()}",
                        style: const TextStyle(
                          fontSize: 16,
                          // color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Text("Total: \$${cartItem.total.toStringAsFixed(2)}"),
                    ],
                  ),
                ],
              ),
              tileColor: isSelected
                  ? Colors.grey.withOpacity(0.3)
                  : Colors.transparent,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          if (selectedProducts.isNotEmpty) {
            showOrderConfirmationDialog(context);
          }
        },
        child: const Icon(
          Icons.payment_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
