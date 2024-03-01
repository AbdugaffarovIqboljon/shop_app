import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/providers/address_screen_provider.dart';
import 'package:shop_app/screens/cart_screen/cart_screen_views/alert_dialog.dart';

import '../../data/services/database/product_database.dart';
import '../../providers/cart_provider.dart';
import 'cart_screen_views/cart_list_view.dart';
import 'cart_screen_views/empty_cart_case.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: _CartScreenContent(),
    );
  }
}

class _CartScreenContent extends StatefulWidget {
  @override
  State<_CartScreenContent> createState() => _CartScreenState();
}

class _CartScreenState extends State<_CartScreenContent> {
  LocalDatabase localDatabase = LocalDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Your Cart",
          style: TextStyle(
            fontSize: 23.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: CartProvider().getSavedItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Some error has gone \nTry Again later :(");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const BuildEmptyCartCase();
          } else {
            List<ProductModel> products = snapshot.data!;
            return CartListView(
              products: products,
              onPressed: (ProductModel product) async {
                final cartProvider =
                    Provider.of<CartProvider>(context, listen: false);
                cartProvider.toggleProductSelection(product: product);
                if (cartProvider.selectedProducts.isNotEmpty) {
                  cartProvider.removeItems(
                    List.from(cartProvider.selectedProducts),
                  );
                  setState(() {});
                }
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () async {
          final cartProvider =
              Provider.of<CartProvider>(context, listen: false);
          showAlertDialog(
            context,
            AddressProvider(),
            () async {
              if (cartProvider.selectedProducts.isNotEmpty) {
                await cartProvider.removeItems(
                  List.from(
                    cartProvider.selectedProducts,
                  ),
                );
              }
              setState(() {});
              if (mounted) Navigator.pop(context);
            },
          );
        },
        child: const Icon(
          Icons.payment_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
