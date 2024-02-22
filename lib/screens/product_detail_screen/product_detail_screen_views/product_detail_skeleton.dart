import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget buildSkeletonDetail() {
  return Skeletonizer(
    enabled: true,
    ignorePointers: false,
    child: Container(
      height: 500.sp,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 350.sp,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 35),
          Container(
            height: 30,
            width: 300.sp,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 20),
          Container(
            height: 30,
            width: 280.sp,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 25),
          Container(
            height: 200.sp,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    ),
  );
}
