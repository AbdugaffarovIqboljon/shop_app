import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/user_info_appbar_provider.dart';
import 'package:shop_app/screens/home_screen/home_screen_views/special_offer.dart';

import '../../components/product_card.dart';
import '../../model/category.dart';
import '../../providers/home_screen_provider.dart';
import '../product_detail_screen/detail_screen.dart';
import 'home_screen_views/build_skeleton_product_card.dart';
import 'home_screen_views/by_categories_header.dart';
import 'home_screen_views/by_categories_widget.dart';
import 'home_screen_views/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<HomeScreenProvider>(context, listen: false);
    provider.initializeData();
  }

  @override
  Widget build(BuildContext context) {
    final HomeScreenProvider provider = Provider.of<HomeScreenProvider>(
      context,
    );

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

    const borderRadius = BorderRadius.all(Radius.circular(20));
    return ChangeNotifierProvider(
      create: (context) => UserInfoProvider(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: true,
              flexibleSpace: HomeAppBar(),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SpecialOffers(),
                    SizedBox(height: 20.h),
                    const ByCategoriesTitle(),
                    SizedBox(height: 15.h),
                    ByCategoriesWidget(
                      onCategorySelected: (index) {
                        final provider = Provider.of<HomeScreenProvider>(
                          context,
                          listen: false,
                        );
                        if (index == 0) {
                          provider.fetchAllData();
                        } else {
                          provider.fetchProductsByCategory(
                            homeCategories[index].id,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.sp,
                  mainAxisSpacing: 12.sp,
                  childAspectRatio: 2 / 3.7,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (provider.productList.isEmpty) {
                      return buildSkeletonProductCard();
                    } else {
                      final product = provider.productList[index];
                      return ProductCard(
                        borderRadius: borderRadius,
                        product: product,
                        onTap: () {
                          navigateToShopDetailScreen(product.id);
                        },
                      );
                    }
                  },
                  childCount: provider.productList.isEmpty
                      ? 6
                      : provider.productList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
