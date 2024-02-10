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
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
          child: Image(
            image: const AssetImage(
              "assets/images/img_card_pattern.png",
            ),
            height: 215.sp,
          ),
        ),
        Transform.translate(
          offset: Offset(340.sp, -6.sp),
          child: Row(
            children: [
              IconButton(
                onPressed: onPressed,
                icon: Image(
                  height: 25.sp,
                  width: 25.sp,
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
          height: 110,
          left: 25,
          child: Row(
            children: [
              Image(
                height: 55.sp,
                width: 55.sp,
                image: const AssetImage("assets/images/img_chip.png"),
              ),
              const SizedBox(width: 10),
              Image(
                height: 33.sp,
                width: 33.sp,
                color: Colors.white,
                image: const AssetImage(
                  "assets/icons/profile/nfc.png",
                ),
              ),
              SizedBox(width: 110.sp),
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
          top: 105,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardNumber,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 24.sp,
                  wordSpacing: 2.45,
                  letterSpacing: 6,
                ),
              ),
              const SizedBox(height: 15),
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
