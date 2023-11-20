import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/model/category.dart';
import 'package:shop_app/model/special_offer.dart';

import '../../../components/special_offer_widget.dart';
import '../../../core/params/apis.dart';
import '../../../core/params/service_locator.dart';
import '../../../model/product_model.dart';

typedef SpecialOffersOnTapSeeAll = void Function();

class SpecialOffers extends StatefulWidget {
  final SpecialOffersOnTapSeeAll? onTapSeeAll;

  const SpecialOffers({super.key, this.onTapSeeAll});

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  late final List<SpecialOffer> specials = homeSpecialOffers;
  late List<ProductModel> _products = [];
  int selectIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      _products = await repository.methodGetAllProducts(
        api: Api.apiGETProducts,
      );
      setState(() {});
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(),
        const SizedBox(height: 24),
        Stack(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              height: 200.sp,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.shade100,
                    offset: Offset(0, 1),
                    blurRadius: 0.8,
                    spreadRadius: 0.8,
                  ),
                ],
              ),
              child: PageView.builder(
                itemBuilder: (context, index) {
                  final data = specials[index];
                  final product = _products[index];
                  return SpecialOfferWidget(
                    context,
                    data: data,
                    index: index,
                    productModel: product,
                  );
                },
                itemCount: _products.length ~/ 4,
                allowImplicitScrolling: true,
                onPageChanged: (value) {
                  setState(() => selectIndex = value);
                },
              ),
            ),
            _buildPageIndicator()
          ],
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Special Offers',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF212121),
          ),
        ),
        TextButton(
          onPressed: () => widget.onTapSeeAll?.call(),
          child: const Text(
            'See All',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF212121),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _products.length ~/ 4; i++) {
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
