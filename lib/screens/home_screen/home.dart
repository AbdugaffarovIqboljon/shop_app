import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/data/network_service.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/screens/home_screen/home_screen_views/special_offer.dart';

import '../../components/product_card.dart';
import '../product_detail_screen/detail_screen.dart';
import '../special_offers_screen/special_offers_screen.dart';
import 'home_screen_views/by_categories_header.dart';
import 'home_screen_views/by_categories_widget.dart';
import 'home_screen_views/home_app_bar.dart';
import 'home_screen_views/search_field.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  void navigateToShopDetailScreen(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShopDetailScreen(
          productId: id,
        ),
      ),
    );
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
                  const SizedBox(height: 15),
                  SpecialOffers(
                    onTapSeeAll: () => _onTapSpecialOffersSeeAll(context),
                  ),
                  const SizedBox(height: 25),
                  const ByCategoriesTitle(),
                  const SizedBox(height: 15),
                  const ByCategoriesWidget(),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.sp,
                mainAxisSpacing: 12.sp,
                childAspectRatio: 2 / 3.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = productList[index];
                  return ProductCard(
                    borderRadius: borderRadius,
                    product: product,
                    onTap: () {
                      navigateToShopDetailScreen(product.id);
                    },
                  );
                },
                childCount: productList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
