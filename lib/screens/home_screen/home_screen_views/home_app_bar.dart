import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_info_appbar_provider.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfoProvider = Provider.of<UserInfoProvider>(context);
    final userData = userInfoProvider.userData;

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      title: Text(
        userData['name']?.isNotEmpty == true
            ? 'Hi, again ${userData['name']} 👋'
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
