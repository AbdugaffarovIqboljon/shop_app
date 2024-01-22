import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:shop_app/services/cart_service/add_to_cart_service.dart';
import 'package:shop_app/services/product_service.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ProductDatabase productDatabase = ProductDatabase();
  await productDatabase.open();
  runApp(
    provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(create: (context) => CartController()),
        provider.Provider<ProductDatabase>.value(value: productDatabase),
      ],
      child: const MyApp(),
    ),
  );
}

