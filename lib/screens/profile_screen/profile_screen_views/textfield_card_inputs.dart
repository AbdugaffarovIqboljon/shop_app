import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextField textFieldCardInputs([
  TextEditingController? cardHolderNameController,
  TextInputAction? textInputAction,
  TextInputType? keyboardType,
  String? hintText,
  int? maxLength,
  void Function(String)? onChanged,
  List<TextInputFormatter>? inputFormatters,
]) {
  return TextField(
    textInputAction: textInputAction,
    keyboardType: keyboardType,
    controller: cardHolderNameController,
    onChanged: onChanged,
    inputFormatters: inputFormatters,
    maxLength: maxLength,
    style: TextStyle(
      fontSize: 20.sp,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: 18.sp,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    ),
  );
}
