import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showDelayedDialog(BuildContext context) {
  showAdaptiveDialog(
    barrierDismissible: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        elevation: 0,
        title: Text(
          "Successfully added to your cart",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 19.sp,
          ),
        ),
      );
    },
  );

  Future.delayed(const Duration(seconds: 1), () {
    Navigator.of(context).pop();
  });
}