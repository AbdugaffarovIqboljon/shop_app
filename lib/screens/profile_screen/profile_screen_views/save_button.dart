import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container buildSaveButton({
  required final void Function() onTap,
}) {
  return Container(
    height: 58.sp,
    width: 160.sp,
    margin: EdgeInsets.only(left: 230.sp),
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
            'Save',
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
