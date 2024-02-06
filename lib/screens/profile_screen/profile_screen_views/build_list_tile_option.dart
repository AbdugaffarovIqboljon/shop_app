import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/screens/profile_screen/about_us_screen.dart';
import 'package:shop_app/screens/profile_screen/profile_screen_views/show_log_out_bottomsheet.dart';

import '../address_screen.dart';
import '../edit_profile_screen.dart';
import '../payment_screen.dart';
import '../profile_screen.dart';
import '../security_screen.dart';

Widget buildOption(
  BuildContext context,
  int index,
  ProfileOption data,
  void Function() onTap,
) {
  return ListTile(
    leading: Image.asset(data.icon, scale: 2),
    title: Text(
      data.title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
        color: data.titleColor,
      ),
    ),
    trailing: data.trailing,
    onTap: () {
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfileScreen(),
            ),
          );
          break;
        case 1:
          // Address Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddressScreen()),
          );
          break;
        case 2:
          // Payment Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymentScreen()),
          );
          break;
        case 3:
          // Security Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecurityScreen()),
          );
          break;
        case 4:
          // About Us Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutUsScreen()),
          );
          break;
        case 5:
          // Log Out Screen
          showLogoutBottomSheet(context: context);
          break;
        default:
          break;
      }
    },
  );
}
