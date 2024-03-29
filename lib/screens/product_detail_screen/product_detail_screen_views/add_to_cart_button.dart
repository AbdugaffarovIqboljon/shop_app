import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget addToCartButton(double price, void Function() onTap) {
  buildAddCard() => Container(
        height: 58.h,
        width: 160.w,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: Colors.deepPurpleAccent.shade700,
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 6),
              blurRadius: 15,
              color: Colors.deepPurpleAccent.withOpacity(0.5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(28.r)),
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/detail/bag@2x.png', scale: 2),
                SizedBox(width: 16.w),
                Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: [
          const Divider(color: Color(0xFFEEEEEE)),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total price',
                    style: TextStyle(
                      color: const Color(0xFF757575),
                      fontSize: 13.sp,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                    ),
                  ),
                ],
              ),
              buildAddCard()
            ],
          ),
          SizedBox(height: 35.h),
        ],
      ),
    ),
  );
}
