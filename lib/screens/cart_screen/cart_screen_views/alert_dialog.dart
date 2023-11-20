import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/services/orders_manager/orders_manager.dart';

void showAlertDialog(
    BuildContext context, ProductModel product, OrdersManager ordersManager) {
  showDialog(
    context: context,
    barrierDismissible: true,
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
              ordersManager.addToOrders(product);
              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
