import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/special_offers_provider.dart';

import '../../../components/special_offer_widget.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SpecialOffersProvider>(context);

    return Column(
      children: [
        const SizedBox(height: 10),
        Stack(
          children: [
            InkWell(
              onTap: () {
                provider.navigateToSpecialOfferScreen(context);
              },
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
                    final data = provider.specials[index];
                    final product = provider.productList[index];
                    return SpecialOfferWidget(
                      context,
                      data: data,
                      index: index,
                      productModel: product,
                    );
                  },
                  itemCount: provider.productList.length ~/ 4,
                  allowImplicitScrolling: true,
                  onPageChanged: (value) {
                    provider.setSelectIndex(value);
                  },
                ),
              ),
            ),
            _buildPageIndicator(provider)
          ],
        ),
      ],
    );
  }

  Widget _buildPageIndicator(SpecialOffersProvider provider) {
    List<Widget> list = [];
    for (int i = 0; i < provider.productList.length ~/ 4; i++) {
      list.add(
        i == provider.selectIndex ? _indicator(true) : _indicator(false),
      );
    }
    return Container(
      height: 195.sp,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 15.sp),
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
      height: 4.0,
      width: isActive ? 16.0 : 4.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(2)),
        color: isActive
            ? Colors.deepPurpleAccent.shade700
            : const Color(0xFFBDBDBD),
      ),
    );
  }
}
