import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Center buildEmptyCart() {
  return Center(
    child: Column(
      children: [
        const SizedBox(height: 120),
        Image(
          image: const AssetImage(
            "assets/icons/home/ic_empty_cart.png",
          ),
          width: 200.sp,
          height: 200.sp,
        ),
        const SizedBox(height: 20),
        Text(
          "Your Cart is Empty",
          style: TextStyle(
            fontSize: 30.sp,
            fontFamily: "Urbanist",
            fontWeight: FontWeight.w600,
            color: Colors.deepPurpleAccent.shade700,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Go find the product you like",
          style: TextStyle(
            fontSize: 17.sp,
            fontFamily: "Urbanist",
            fontWeight: FontWeight.w500,
            color: Colors.deepPurpleAccent.shade700,
          ),
        ),
      ],
    ),
  );
}
