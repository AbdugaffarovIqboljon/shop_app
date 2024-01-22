import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Widget> buildTitle(
    String productName,
    num rate,
    int count,
    num price,
    ) {
  return <Widget>[
    const SizedBox(height: 10),
    Text(
      productName,
      maxLines: 3,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
    ),
    const SizedBox(height: 30),
    Row(
      children: [
        Text(
          '\$$price',
          style: TextStyle(
            fontSize: 21.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 30),
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
        const SizedBox(width: 16),
        const Icon(Icons.star_rate, color: Colors.orange),
        const SizedBox(width: 8),
        Text(
          '$rate rating',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  ];
}