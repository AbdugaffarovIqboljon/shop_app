import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/screens/cart_screen/cart_screen_views/alert_dialog.dart';

import '../../services/product_service.dart';
import 'cart_screen_views/cart_list_view.dart';
import 'cart_screen_views/empty_cart_case.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

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
        future: localDatabase.getSavedItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("ERROR: ${snapshot.error}");
            return const Text("Some Error has gone \nTry Again later:(");
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return buildEmptyCart();
          } else {
            List<ProductModel> products = snapshot.data!;
            return buildListView(
              context,
              products,
              (ProductModel product) async {
                final cartProvider = Provider.of<CartProvider>(
                  context,
                  listen: false,
                );
                await cartProvider.removeItems(product);
                setState(() {});
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          final cartProvider = Provider.of<CartProvider>(
            context,
            listen: false,
          );
          if (cartProvider.selectedProducts.isEmpty) return;
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

class CartProvider extends ChangeNotifier {
  List<ProductModel> selectedProducts = [];
  LocalDatabase localDatabase = LocalDatabase();

  void toggleProductSelection({required ProductModel product}) {
    if (selectedProducts.contains(product)) {
      selectedProducts.remove(product);
    } else {
      selectedProducts.add(product);
    }
    notifyListeners();
  }

  Future<void> removeItems(ProductModel product) async {
    localDatabase.removeItem(product);
    notifyListeners();
  }
}
