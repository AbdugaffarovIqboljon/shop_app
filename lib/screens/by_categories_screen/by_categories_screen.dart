import 'package:flutter/material.dart';
import 'package:shop_app/components/app_bar.dart';
import 'package:shop_app/components/product_card.dart';

import '../../core/params/apis.dart';
import '../../core/params/service_locator.dart';
import '../../model/product_model.dart';

class ByCategoriesScreen extends StatefulWidget {
  const ByCategoriesScreen({super.key});

  static String route() => '/by_categories';

  @override
  State<ByCategoriesScreen> createState() => _ByCategoriesScreenState();
}

class _ByCategoriesScreenState extends State<ByCategoriesScreen> {
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

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 10, vertical: 15);
    return Scaffold(
      appBar: FRAppBar.defaultAppBar(
        context,
        title: 'Most Popular',
      ),
      body: CustomScrollView(slivers: [
        SliverPadding(
          padding: padding,
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
              childAspectRatio: 2 / 3.7,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = _products[index];
                return ProductCard(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(19),
                  ),
                  product: product,
                );
              },
              childCount: _products.length,
            ),
          ),
        ),
      ]),
    );
  }
}
