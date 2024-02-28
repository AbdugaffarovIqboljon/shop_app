import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/providers/address_screen_provider.dart';
import 'package:shop_app/utils.dart';

void showAlertDialog(
  BuildContext context,
  AddressProvider addressProvider,
  void Function() onPressed,
) async {
  await addressProvider.getAddressFromDatabase();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset("assets/lotties/delivery_lottie.json"),
            SizedBox(height: 30.h),
            Text(
              "Your order will be delivered in 1-2 days to your address: ${removeBrackets(addressProvider.country)}, ${removeBrackets(addressProvider.street)}",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.sp,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
