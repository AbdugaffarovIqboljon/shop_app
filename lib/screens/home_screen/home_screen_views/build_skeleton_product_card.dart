import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget buildSkeletonProductCard() {
  return Skeletonizer(
    enabled: true,
    ignorePointers: false,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150.sp,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 20,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 5),
          Container(
            height: 20,
            width: 100,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 10),
          Container(
            height: 20,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    ),
  );
}