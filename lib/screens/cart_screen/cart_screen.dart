import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/model/cart_model.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/screens/cart_screen/cart_screen_views/alert_dialog.dart';
import 'package:shop_app/services/cart_service/add_to_cart_service.dart';

import '../../services/product_service.dart';
import 'cart_screen_views/empty_cart_case.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ProductModel> selectedProducts = [];
  ProductDatabase productDatabase = ProductDatabase();
  ProductService productService = ProductService();
  bool isListTileTapped = false;

  void toggleProductSelection(ProductModel product) {
    setState(() {
      if (selectedProducts.contains(product)) {
        selectedProducts.remove(product);
      } else {
        selectedProducts.add(product);
      }
    });
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
      body: FutureBuilder<List<ProductModel>>(
        future: productService.getSavedProducts(),
        builder: (context, snapshot) {
          List<CartItem> cartItems = MyProvider.of(context).cart.items;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return buildEmptyCart();
          } else {
            List<ProductModel> products = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final cartItem = cartItems.firstWhere(
                  (item) => item.product.id == product.id,
                  orElse: () => CartItem(id: 1, product: product),
                );

                final isSelected = selectedProducts.contains(product);

                return SizedBox(
                  height: 130.sp,
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? Colors.grey.shade700
                            : Colors.grey.shade200,
                      ),
                    ),
                    elevation: 0,
                    clipBehavior: Clip.antiAlias,
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        toggleProductSelection(product);
                      },
                      minLeadingWidth: 50.sp,
                      leading: Image(
                        height: 80.sp,
                        width: 80.sp,
                        image: NetworkImage(product.image),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Quantity: ${cartItem.quantity.toString()}",
                            style: const TextStyle(
                              fontSize: 16,
                              // color: Colors.white,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total: \$${cartItem.total.toStringAsFixed(2)}",
                              ),
                              IconButton(
                                onPressed: () {
                                  // productDatabase.removeProduct(product.id);
                                },
                                icon: const Icon(Icons.delete_rounded),
                              ),
                            ],
                          ),
                        ],
                      ),
                      tileColor: isSelected ? Colors.grey.shade100 : Colors.transparent,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          if (selectedProducts.isEmpty) return;
          showAlertDialog(context);
        },
        child: const Icon(
          Icons.payment_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
