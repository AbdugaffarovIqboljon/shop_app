import 'package:flutter/material.dart';
import 'package:shop_app/screens/by_categories_screen/by_categories_screen.dart';
import 'package:shop_app/screens/coming_soon_screen/test_screen.dart';
import 'package:shop_app/screens/home_screen/home.dart';
import 'package:shop_app/screens/product_detail_screen/detail_screen.dart';
import 'package:shop_app/screens/profile_screen/profile_screen.dart';
import 'package:shop_app/screens/special_offers_screen/special_offers_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.route(): (context) => const HomeScreen(title: '123'),
  ByCategoriesScreen.route(): (context) => const ByCategoriesScreen(),
  SpecialOfferScreen.route(): (context) => const SpecialOfferScreen(),
  ProfileScreen.route(): (context) => const ProfileScreen(),
  ShopDetailScreen.route(): (context) => const ShopDetailScreen(),
  TestScreen.route(): (context) => const TestScreen(),
};
