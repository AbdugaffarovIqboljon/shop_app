import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Widget> buildDescription(String description) {
  return [
    Text(
      'Description',
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    const SizedBox(height: 8),
    ExpandableText(
      description,
      expandText: 'view more',
      collapseText: 'view less',
      textAlign: TextAlign.start,
      maxLines: 3,
      animation: true,
      animationDuration: const Duration(milliseconds: 800),
      animationCurve: Curves.linearToEaseOut,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      linkStyle: const TextStyle(
        fontSize: 17,
        color: Color(0xFF424242),
        fontWeight: FontWeight.bold,
      ),
    ),
  ];
}
