import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/providers/address_screen_provider.dart';
import 'package:shop_app/utils.dart';

Widget buildSavedAddressSection(AddressProvider addressProvider) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your Saved Address:",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 19.sp,
            color: Colors.deepPurpleAccent.shade700,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.deepPurpleAccent.shade700,
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "${removeBrackets(addressProvider.country)}, ${removeBrackets(addressProvider.street)}",
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                onPressed: () {
                  addressProvider.editLocation();
                },
                icon: Image(
                  image: const AssetImage(
                    "assets/icons/profile/location_edit.png",
                  ),
                  height: 30.sp,
                  width: 30.sp,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
