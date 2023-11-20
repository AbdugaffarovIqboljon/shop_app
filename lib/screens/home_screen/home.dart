import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/core/params/apis.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/screens/home_screen/home_screen_views/special_offer.dart';

import '../../components/product_card.dart';
import '../../core/params/service_locator.dart';
import '../by_categories_screen/by_categories_screen_views/by_categories_header.dart';
import '../by_categories_screen/by_categories_screen_views/by_categories_widget.dart';
import '../special_offers_screen/special_offers_screen.dart';
import 'home_screen_views/home_app_bar.dart';
import 'home_screen_views/search_field.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  static String route() => '/home';

  const HomeScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ProductModel> _products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      _products =
          await repository.methodGetAllProducts(api: Api.apiGETProducts);
      setState(() {});
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void _onTapSpecialOffersSeeAll(BuildContext context) {
    Navigator.pushNamed(context, SpecialOfferScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(20));
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            flexibleSpace: HomeAppBar(),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SearchField(),
                  const SizedBox(height: 10),
                  SpecialOffers(
                    onTapSeeAll: () => _onTapSpecialOffersSeeAll(context),
                  ),
                  const SizedBox(height: 25),
                  const ByCategoriesTitle(),
                  const SizedBox(height: 15),
                  const ByCategoriesWidget(),
                  const SizedBox(height: 25),
                  Text(
                    "Most Popular",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21.sp,
                      color: const Color(0xFF212121),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.sp,
                mainAxisSpacing: 12.sp,
                childAspectRatio: 2 / 3.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = _products[index];
                  return ProductCard(
                    borderRadius: borderRadius,
                    product: product,
                  );
                },
                childCount: _products.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
