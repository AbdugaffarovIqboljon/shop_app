import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      title: const Text(
        'Good Morning \t👋',
        style: TextStyle(
          color: Color(0xFF212121),
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.start,
      ),
      actions: [
        IconButton(
          icon: Image.asset(
            "assets/icons/profile/notification@2x.png",
            height: 32.sp,
            width: 32.sp,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}
