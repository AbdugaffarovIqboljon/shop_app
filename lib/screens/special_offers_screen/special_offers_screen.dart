import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/app_bar.dart';
import 'package:shop_app/components/special_offer_widget.dart';
import 'package:shop_app/providers/special_offers_provider.dart';

import '../product_detail_screen/detail_screen.dart';

class SpecialOfferScreen extends StatelessWidget {
  const SpecialOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SpecialOffersProvider>(context);

    return Scaffold(
      appBar: BasicAppBar.defaultAppBar(
        context,
        title: 'Special Offers',
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 35),
        itemBuilder: (context, index) {
          final data = provider.specials[index];
          final product = provider.productList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopDetailScreen(productId: product.id),
                ),
              );
            },
            child: Container(
              height: 180.sp,
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: const BorderRadius.all(Radius.circular(25)),
              ),
              child: SpecialOfferWidget(
                context,
                data: data,
                index: index,
                productModel: product,
              ),
            ),
          );
        },
        itemCount: provider.productList.length ~/ 4,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 20);
        },
      ),
    );
  }
}
