import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class BuildEmptyCartCase extends StatefulWidget {
  const BuildEmptyCartCase({super.key});

  @override
  State<BuildEmptyCartCase> createState() => _BuildEmptyCartCaseState();
}

class _BuildEmptyCartCaseState extends State<BuildEmptyCartCase>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: -1, end: 0),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, MediaQuery.of(context).size.height * value),
          child: child,
        );
      },
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 120),
            Image(
              image: const AssetImage(
                "assets/icons/home/ic_empty_cart.png",
              ),
              width: 200.sp,
              height: 200.sp,
            ),
            const SizedBox(height: 20),
            Text(
              "Your Cart is Empty",
              style: TextStyle(
                fontSize: 30.sp,
                fontFamily: "Urbanist",
                fontWeight: FontWeight.w600,
                color: Colors.deepPurpleAccent.shade700,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Go find the product you like",
              style: TextStyle(
                fontSize: 17.sp,
                fontFamily: "Urbanist",
                fontWeight: FontWeight.w500,
                color: Colors.deepPurpleAccent.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
