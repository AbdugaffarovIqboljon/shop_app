import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Widget> buildTitle(
  String productName,
  num rate,
  int count,
) {
  return [
    const SizedBox(height: 10),
    Text(
      productName,
      maxLines: 3,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
    ),
    const SizedBox(height: 30),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$rate \u2B50 \trating',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Color(0xFFEEEEEE),
          ),
          child: Text(
            '$count left',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  ];
}
