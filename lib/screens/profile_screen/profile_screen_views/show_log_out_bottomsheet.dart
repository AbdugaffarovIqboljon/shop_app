import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/user_database.dart';
import 'log_out_button.dart';

Future showLogoutBottomSheet({
  required BuildContext context,
}) async {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    useSafeArea: true,
    elevation: 30,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Text(
                "Log Out",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 23,
                  color: Color(0xFFF85656),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              indent: 10,
              endIndent: 10,
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "Do you really want to log out?",
                style: TextStyle(fontSize: 19.sp),
              ),
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// #Cancel Button
                buildLogOutButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  displayText: "Cancel",
                ),

                /// #Sure To LogOut
                buildLogOutButton(
                  onTap: () async {
                    UserInfoDatabase.deleteUserInfo();
                    Navigator.pop(context);
                  },
                  displayText: "Yes, Log Out",
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
