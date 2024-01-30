import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart_screen/cart_screen.dart';
import 'package:shop_app/screens/profile_screen/profile_screen.dart';
import 'package:shop_app/screens/saved_products_screen/saved_products_screen.dart';

import '../components/bottom_navbar.dart';
import 'home_screen/home.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  PageController pageController = PageController();
  int bottomNavBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          HomeScreen(),
          CartScreen(),
          SavedProductsScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        onTap: (value) {
          bottomNavBarIndex = value;
          pageController.jumpToPage(bottomNavBarIndex);
          setState(() {});
        },
        bottomNavbarIndex: bottomNavBarIndex,
      ),
    );
  }
}
