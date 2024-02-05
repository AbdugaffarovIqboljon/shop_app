import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/utils.dart';

Container buildCardInputs({
  required BuildContext context,
  required TextEditingController cardNumberController,
  required TextEditingController cardHolderNameController,
}) {
  return Container(
    height: 280.sp,
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
    decoration: const BoxDecoration(
      color: Color(0xFF15171D),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.sp),
          Text(
            'Card Number: ',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.sp),
          TextField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            controller: cardNumberController,
            maxLength: 19,
            onChanged: (input) {
              if (input.length == 19) {
                FocusScope.of(context).nextFocus();
              }
            },
            inputFormatters: [CardNumberFormatter()],
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintText: '0000 0000 0000 0000',
              hintStyle: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              counter: const SizedBox.shrink(),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(height: 15.sp),
          Text(
            'Your Name: ',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.sp),
          TextField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.name,
            controller: cardHolderNameController,
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintText: 'CARDHOLDER NAME',
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
          ),
        ],
      ),
    ),
  );
}
