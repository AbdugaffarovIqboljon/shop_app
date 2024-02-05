import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/user_info_service.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
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
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      title: Text(
        _userData['name']?.isNotEmpty == true
            ? 'Hi, again ${_userData['name']} 👋'
            : 'Hi, again 👋',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22.sp,
          fontFamily: "Urbanist",
        ),
        overflow: TextOverflow.ellipsis,
        softWrap: true,
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
