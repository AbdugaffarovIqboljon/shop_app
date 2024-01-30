import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/data/network_service.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/screens/home_screen/home_screen_views/special_offer.dart';

import '../../components/product_card.dart';
import '../../model/category.dart';
import '../product_detail_screen/detail_screen.dart';
import 'home_screen_views/build_skeleton_product_card.dart';
import 'home_screen_views/by_categories_header.dart';
import 'home_screen_views/by_categories_widget.dart';
import 'home_screen_views/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NetworkService productService = NetworkService();
  List<ProductModel> productList = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
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

  Future<void> fetchProductsByCategory(String category) async {
    try {
      setState(() {
        productList = [];
      });

      List<ProductModel> fetchedProducts =
          await productService.methodGetProductsByCategory(category: category);

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

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(20));
    return ChangeNotifierProvider(
      create: (context) => LikedProductsProvider(),
      child: Scaffold(
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
                    /// #Header Special Offers
                    const SpecialOffers(),

                    SizedBox(height: 35.sp),

                    /// #Categories Header Title
                    const ByCategoriesTitle(),

                    const SizedBox(height: 15),

                    /// #Categories Sub Widgets
                    ByCategoriesWidget(
                      onCategorySelected: (index) {
                        if (index == 0) {
                          fetchAllData();
                        } else {
                          fetchProductsByCategory(homeCategories[index].id);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),

            /// #Product SliverGrid
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
                    if (productList.isEmpty) {
                      return buildSkeletonProductCard();
                    } else {
                      final product = productList[index];
                      return ProductCard(
                        borderRadius: borderRadius,
                        product: product,
                        onTap: () {
                          navigateToShopDetailScreen(product.id);
                        },
                      );
                    }
                  },
                  childCount: productList.isEmpty ? 6 : productList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
