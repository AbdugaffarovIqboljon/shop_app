import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/components/app_bar.dart';
import 'package:shop_app/components/special_offer_widget.dart';
import 'package:shop_app/data/network_service.dart';

import '../../model/product_model.dart';
import '../../model/special_offer.dart';
import '../product_detail_screen/detail_screen.dart';

class SpecialOfferScreen extends StatefulWidget {
  const SpecialOfferScreen({super.key});

  @override
  State<SpecialOfferScreen> createState() => _SpecialOfferScreenState();

  static String route() => '/special_offers';
}

class _SpecialOfferScreenState extends State<SpecialOfferScreen> {
  late final List<SpecialOffer> datas = homeSpecialOffers;
  final NetworkService productService = NetworkService();
  List<ProductModel> productList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<ProductModel> fetchedProducts =
          await productService.methodGetAllProducts();
      setState(() {
        productList = fetchedProducts;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FRAppBar.defaultAppBar(
        context,
        title: 'Special Offers',
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 35),
        itemBuilder: (context, index) {
          final data = datas[index];
          final product = productList[index];
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
        itemCount: productList.length ~/ 4,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 20);
        },
      ),
    );
  }
}
