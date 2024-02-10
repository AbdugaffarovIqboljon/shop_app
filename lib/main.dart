import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screen/cart_screen.dart';
import 'package:shop_app/screens/product_detail_screen/detail_screen.dart';
import 'package:shop_app/screens/profile_screen/payment_screen.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ShopDetailProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
