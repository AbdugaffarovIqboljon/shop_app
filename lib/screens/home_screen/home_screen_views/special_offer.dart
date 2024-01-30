import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/data/network_service.dart';
import 'package:shop_app/model/special_offer.dart';
import 'package:shop_app/screens/special_offers_screen/special_offers_screen.dart';

import '../../../components/special_offer_widget.dart';
import '../../../model/product_model.dart';

typedef SpecialOffersOnTapSeeAll = void Function();

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({super.key});

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  late final List<SpecialOffer> specials = homeSpecialOffers;
  int selectIndex = 0;

  final NetworkService productService = NetworkService();
  List<ProductModel> productList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void navigateToSpecialOfferScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SpecialOfferScreen()),
    );
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
    return Column(
      children: [
        const SizedBox(height: 10),
        Stack(
          children: [
            InkWell(
              onTap: navigateToSpecialOfferScreen,
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: 200.sp,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 0),
                      blurRadius: 0.5,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    final data = specials[index];
                    final product = productList[index];
                    return SpecialOfferWidget(
                      context,
                      data: data,
                      index: index,
                      productModel: product,
                    );
                  },
                  itemCount: productList.length ~/ 4,
                  allowImplicitScrolling: true,
                  onPageChanged: (value) {
                    setState(() => selectIndex = value);
                  },
                ),
              ),
            ),
            _buildPageIndicator()
          ],
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < productList.length ~/ 4; i++) {
      list.add(i == selectIndex ? _indicator(true) : _indicator(false));
    }
    return Container(
      height: 195.sp,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list,
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 4.0.sp,
      width: isActive ? 16.sp : 4.0.sp,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(2)),
        color: isActive
            ? Colors.deepPurpleAccent.shade700
            : const Color(0xFFBDBDBD),
      ),
    );
  }
}
