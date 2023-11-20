import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
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
          icon: Icon(
            CupertinoIcons.heart,
            size: 31.sp,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            CupertinoIcons.bell,
            size: 31.sp,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}
