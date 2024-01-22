import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/screens/main_home_screen.dart';
import 'package:shop_app/services/cart_service/add_to_cart_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyProvider(
      child: ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(430, 932),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Urbanist',
          ),
          themeMode: ThemeMode.light,
          // routes: routes,
          home: const MainHomeScreen(),
        ),
      ),
    );
  }
}
