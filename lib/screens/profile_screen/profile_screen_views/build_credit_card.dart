import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowCreditCard extends StatelessWidget {
  final String cardNumber;
  final String cardHolderName;
  final void Function()? onPressed;

  const ShowCreditCard({
    super.key,
    required this.cardNumber,
    required this.cardHolderName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.all(
            Radius.circular(23.r),
          ),
          child: Image(
            image: const AssetImage(
              "assets/images/img_card_pattern.png",
            ),
            height: 215.sp,
          ),
        ),
        Positioned(
          left: 345.w,
          top: 1.h,
          child: Row(
            children: [
              IconButton(
                onPressed: onPressed,
                icon: Image(
                  height: 25.h,
                  width: 25.w,
                  color: Colors.white,
                  image: const AssetImage(
                    "assets/icons/profile/edit.png",
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          height: 125.h,
          left: 25.w,
          child: Row(
            children: [
              Image(
                height: 55.h,
                width: 55.w,
                image: const AssetImage("assets/images/img_chip.png"),
              ),
              SizedBox(width: 10.w),
              Image(
                height: 33.h,
                width: 33.w,
                color: Colors.white,
                image: const AssetImage(
                  "assets/icons/profile/nfc.png",
                ),
              ),
              SizedBox(width: 110.w),
              Text(
                'Credit Card',
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontFamily: "Urbanist",
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 105.h,
          left: 20.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardNumber,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 23.sp,
                  wordSpacing: 2.45.w,
                  letterSpacing: 6.w,
                ),
              ),
              SizedBox(height: 12.w),
              Text(
                cardHolderName,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 21.sp,
                  fontFamily: "Urbanist",
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
