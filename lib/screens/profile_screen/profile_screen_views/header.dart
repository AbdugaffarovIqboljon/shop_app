import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 60.sp,
                  backgroundImage: const AssetImage('assets/icons/home/img.png'),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      child: Image.asset(
                        'assets/icons/profile/edit_square@2x.png',
                        scale: 2,
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'IqboljonFlutterDev',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23.sp,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'coderikhbolsheikh@gmail.com',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
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
