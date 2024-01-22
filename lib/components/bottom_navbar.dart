import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int) onTap;
  final int bottomNavbarIndex;

  const BottomNavBar({
    super.key,
    required this.bottomNavbarIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        icon: Image(
          image: const AssetImage('assets/icons/tabbar/ic_house_chimney.png'),
          height: 21.sp,
          width: 21.sp,
        ),
        activeIcon: Image(
          image: const AssetImage('assets/icons/tabbar/ic_house_chimney_fill.png'),
          height: 21.sp,
          width: 21.sp,
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Image(
          image: const AssetImage('assets/icons/tabbar/shopping-cart.png'),
          height: 22.sp,
          width: 22.sp,
        ),
        activeIcon: Image(
          image: const AssetImage('assets/icons/tabbar/ic_cart_shopping_fast_fill.png'),
          height: 22.sp,
          width: 22.sp,
        ),
        label: 'Cart',
      ),
      BottomNavigationBarItem(
        icon: Image(
          image: const AssetImage('assets/icons/tabbar/ic_box.png'),
          height: 18.sp,
          width: 18.sp,
        ),
        activeIcon: Image(
          image: const AssetImage('assets/icons/tabbar/ic_box_fill.png'),
          height: 18.sp,
          width: 18.sp,
        ),
        label: 'Orders',
      ),
      BottomNavigationBarItem(
        icon: Image(
          image: const AssetImage('assets/icons/tabbar/ic_user.png'),
          height: 21.sp,
          width: 21.sp,
        ),
        activeIcon: Image(
          image: const AssetImage('assets/icons/tabbar/ic_user_fill.png'),
          height: 21.sp,
          width: 21.sp,
        ),
        label: 'Profile',
      ),
    ];
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      mouseCursor: MouseCursor.uncontrolled,
      showSelectedLabels: true,
      currentIndex: bottomNavbarIndex,
      onTap: onTap,
      items: items,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
      showUnselectedLabels: true,
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      // selectedItemColor: Colors.deepPurpleAccent,
      unselectedItemColor: const Color(0xFF9E9E9E),
    );
  }
}
