import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/screens/profile_screen/profile_screen_views/textfield_card_inputs.dart';
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
          textFieldCardInputs(
            cardNumberController,
            TextInputAction.next,
            TextInputType.number,
            "0000 0000 0000 0000",
            19,
            (input) {
              if (input.length == 19) {
                FocusScope.of(context).nextFocus();
              }
            },
            [CardNumberFormatter()],
          ),
          Text(
            'Your Name: ',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.sp),
          textFieldCardInputs(
            cardHolderNameController,
            TextInputAction.done,
            TextInputType.name,
            'CARDHOLDER NAME',
          ),
        ],
      ),
    ),
  );
}
