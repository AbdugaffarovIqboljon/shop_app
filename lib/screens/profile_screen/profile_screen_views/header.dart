import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            CircleAvatar(
              radius: 60.sp,
              backgroundImage:
                  const AssetImage('assets/icons/home/img.png'),
            ),
            SizedBox(width: 30.sp),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Full Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                const SizedBox(height: 10),
                Text(
                  'Your Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
            const SizedBox(),
          ],
        ),
        const SizedBox(height: 15),
        const Divider(
          thickness: 1.5,
          color: Color(0xFFEEEEEE),
        ),
      ],
    );
  }
}
