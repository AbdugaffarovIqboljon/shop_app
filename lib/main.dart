import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/address_screen_provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/home_screen_provider.dart';
import 'package:shop_app/providers/liked_products_provider.dart';
import 'package:shop_app/providers/payment_provider.dart';
import 'package:shop_app/providers/shop_detail_provider.dart';
import 'package:shop_app/providers/special_offers_provider.dart';
import 'package:shop_app/providers/user_info_appbar_provider.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (_) => UserInfoProvider()),
        ChangeNotifierProvider(create: (_) => LikedProductsProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => SpecialOffersProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ShopDetailProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
