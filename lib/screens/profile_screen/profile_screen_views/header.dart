import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/user_database.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  late StreamSubscription _streamSubscription;
  late Map<String, String> _userData = {};

  @override
  void initState() {
    super.initState();
    _streamSubscription = UserInfoDatabase.userInfoStream.listen((userData) {
      if (mounted) {
        setState(() {
          _userData = userData;
        });
      }
    });

    UserInfoDatabase.getUserInfo().then((userInfo) {
      if (mounted && userInfo != null) {
        setState(() {
          _userData = userInfo;
        });
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// #User Details
        Column(
          children: [
            Row(
              children: [
                const Spacer(),
                SizedBox(
                  height: 65.sp,
                  width: 65.sp,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/icons/home/img.png',
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                Expanded(
                  flex: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userData['name'] ?? 'Your Full Name',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _userData['email'] ?? 'Your Email',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),

        SizedBox(height: 35.sp),

        /// #Divider
        const Divider(
          thickness: 1.5,
          color: Color(0xFFEEEEEE),
        ),
      ],
    );
  }
}
