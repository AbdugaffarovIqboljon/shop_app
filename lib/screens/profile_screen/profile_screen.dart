import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/screens/profile_screen/payment_screen.dart';
import 'package:shop_app/screens/profile_screen/profile_screen_views/header.dart';
import 'package:shop_app/screens/profile_screen/security_screen.dart';

import 'about_us_screen.dart';
import 'address_screen.dart';
import 'edit_profile_screen.dart';

typedef ProfileOptionTap = void Function();

class ProfileOption {
  String title;
  String icon;
  Color? titleColor;
  ProfileOptionTap? onClick;
  Widget? trailing;

  ProfileOption({
    required this.title,
    required this.icon,
    this.onClick,
    this.titleColor,
    this.trailing,
  });

  ProfileOption.arrow({
    required this.title,
    required this.icon,
    this.onClick,
    this.titleColor = const Color(0xFF212121),
    this.trailing = const Image(
      image: AssetImage(
        'assets/icons/profile/arrow_right@2x.png',
      ),
      width: 24,
      height: 24,
    ),
  });
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static _profileIcon(String last) => 'assets/icons/profile/$last';

  get datas => <ProfileOption>[
        ProfileOption.arrow(
          title: 'Edit Profile',
          icon: _profileIcon('user@2x.png'),
        ),
        ProfileOption.arrow(
          title: 'Address',
          icon: _profileIcon('location@2x.png'),
        ),
        ProfileOption.arrow(
          title: 'Payment',
          icon: _profileIcon('wallet@2x.png'),
        ),
        ProfileOption.arrow(
          title: 'Security',
          icon: _profileIcon('shield_done@2x.png'),
        ),
        ProfileOption.arrow(
          title: 'About Us',
          icon: _profileIcon('info_square@2x.png'),
        ),
        ProfileOption(
          title: 'Logout',
          icon: _profileIcon('logout@2x.png'),
          titleColor: const Color(0xFFF75555),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: Image.asset('assets/icons/profile/logo@2x.png', scale: 2),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 23.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              Padding(
                padding: EdgeInsets.only(top: 30.sp, bottom: 10.sp),
                child: const ProfileHeader(),
              ),
            ]),
          ),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 10.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final data = datas[index];
            return _buildOption(
              context,
              index,
              data,
              () {},
            );
          },
          childCount: datas.length,
        ),
      ),
    );
  }

  Widget _buildOption(
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
                  builder: (context) => const EditProfileScreen()),
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
            // break;
            // case 5:
            // Log Out Screen
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => LogoutScreen()),
            // );
            break;
          default:
            break;
        }
      },
    );
  }
}
