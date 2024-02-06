import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container buildLogOutButton({
  required void Function()? onTap,
  required String displayText,
}) {
  return Container(
    height: 52.sp,
    width: 160.sp,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      color: Colors.deepPurpleAccent.shade700,
      boxShadow: [
        BoxShadow(
          offset: const Offset(4, 6),
          blurRadius: 15,
          color: Colors.deepPurpleAccent.withOpacity(0.6),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: Center(
          child: Text(
            displayText,
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
