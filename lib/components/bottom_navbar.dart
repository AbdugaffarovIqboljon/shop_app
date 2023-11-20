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
          image: const AssetImage('assets/icons/tabbar/house-chimney.png'),
          height: 19.sp,
          width: 19.sp,
        ),
        activeIcon: Image(
          image: const AssetImage('assets/icons/tabbar/house-chimney (1).png'),
          height: 19.sp,
          width: 19.sp,
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Image(
          image: const AssetImage('assets/icons/tabbar/shopping-cart.png'),
          height: 19.sp,
          width: 19.sp,
        ),
        activeIcon: Image(
          image: const AssetImage('assets/icons/tabbar/shopping-cart (1).png'),
          height: 19.sp,
          width: 19.sp,
        ),
        label: 'Cart',
      ),
      BottomNavigationBarItem(
        icon: Image(
          image: const AssetImage('assets/icons/tabbar/truck-side.png'),
          height: 19.sp,
          width: 19.sp,
        ),
        activeIcon: Image(
          image: const AssetImage('assets/icons/tabbar/truck-side (1).png'),
          height: 19.sp,
          width: 19.sp,
        ),
        label: 'Orders',
      ),
      BottomNavigationBarItem(
        icon: Image(
          image: const AssetImage('assets/icons/tabbar/user.png'),
          height: 19.sp,
          width: 19.sp,
        ),
        activeIcon: Image(
          image: const AssetImage('assets/icons/tabbar/user (1).png'),
          height: 19.sp,
          width: 19.sp,
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
        fontSize: 10,
      ),
      showUnselectedLabels: true,
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
      selectedItemColor: Colors.deepPurpleAccent,
      unselectedItemColor: const Color(0xFF9E9E9E),
    );
  }
}
