import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen/product_detail_screen_views/add_to_cart_button.dart';
import 'package:shop_app/screens/product_detail_screen/product_detail_screen_views/added_to_cart_dialog.dart';
import 'package:shop_app/screens/product_detail_screen/product_detail_screen_views/build_tile.dart';
import 'package:shop_app/screens/product_detail_screen/product_detail_screen_views/product_description.dart';
import 'package:shop_app/screens/product_detail_screen/product_detail_screen_views/product_detail_skeleton.dart';

import '../../data/network_service.dart';
import '../../model/product_model.dart';
import '../../services/product_service.dart';

class ShopDetailScreen extends StatefulWidget {
  final int productId;

  const ShopDetailScreen({super.key, required this.productId});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  LocalDatabase localDatabase = LocalDatabase();

  Widget _buildQuantity(ShopDetailProvider shopDetailProvider) {
    return Row(
      children: [
        const Text(
          'Quantity',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 20),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            color: Color(0xFFF3F3F3),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                InkWell(
                  child: const Icon(Icons.remove),
                  onTap: () {
                    if (shopDetailProvider.quantity <= 0) return;
                    shopDetailProvider.updateQuantity(
                      shopDetailProvider.quantity - 1,
                    );
                  },
                ),
                const SizedBox(width: 20),
                Text(
                  '${shopDetailProvider.quantity}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  child: const Icon(Icons.add),
                  onTap: () => shopDetailProvider.updateQuantity(
                    shopDetailProvider.quantity + 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopDetailProvider>(
      builder: (context, shopDetailProvider, child) {
        return Scaffold(
          body: Stack(
            children: [
              SizedBox(
                height: 1000.sp,
                child: FutureBuilder<ProductModel>(
                  future:
                      shopDetailProvider.loadProductDetails(widget.productId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return buildSkeletonDetail();
                    } else {
                      final product = snapshot.data!;
                      return SingleChildScrollView(
                        primary: true,
                        child: Column(
                          children: [
                            SizedBox(height: 50.sp),
                            Align(
                              alignment: Alignment(0.95.sp, 0),
                              child: IconButton(
                                onPressed: () =>
                                    shopDetailProvider.toggleCollection(),
                                icon: Image.asset(
                                  'assets/icons/${shopDetailProvider.isCollected ? 'bold' : 'light'}/heart@2x.png',
                                  height: 35.sp,
                                ),
                              ),
                            ),
                            Image(
                              height: 300.sp,
                              width: 350.sp,
                              image: NetworkImage(product.image),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...buildTitle(
                                    product.title,
                                    product.rating.rate,
                                    product.rating.count,
                                  ),
                                  const SizedBox(height: 15),
                                  const Divider(color: Color(0xFFEEEEEE)),
                                  const SizedBox(height: 15),
                                  ...buildDescription(product.description),
                                  const SizedBox(height: 15),
                                  _buildQuantity(shopDetailProvider),
                                  SizedBox(height: 125.sp),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),

              /// #Add to Cart Button
              addToCartButton(
                shopDetailProvider.productPrice,
                () {
                  shopDetailProvider.addToCart();
                  showDelayedDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ShopDetailProvider extends ChangeNotifier {
  final NetworkService productService = NetworkService();
  final LocalDatabase localDatabase = LocalDatabase();

  bool _isCollected = false;
  ProductModel? _product;
  int _quantity = 0;

  Future<ProductModel> loadProductDetails(int productId) async {
    try {
      _product =
          await productService.methodGetProductById(productId: productId);
      notifyListeners();
      return _product!;
    } catch (e) {
      print('Error fetching product details: $e');
      rethrow;
    }
  }

  void toggleCollection() {
    List<ProductModel> likedProducts = [];
    LocalDatabase localDatabase = LocalDatabase();

    if (likedProducts.contains(product)) {
      likedProducts.remove(product);
      localDatabase.removeLikedProduct(product);
      _isCollected = !_isCollected;
    } else {
      likedProducts.add(product);
      localDatabase.saveLikedProducts(likedProducts);
      _isCollected = !_isCollected;
    }
    notifyListeners();
  }

  void updateQuantity(int newQuantity) {
    _quantity = newQuantity;
    notifyListeners();
  }

  void addToCart() {
    localDatabase.saveData(
      product: product,
      quantity: _quantity == 0 ? 1 : _quantity,
    );
    notifyListeners();
  }

  bool get isCollected => _isCollected;

  ProductModel get product => _product!;

  double get productPrice => _product?.price.toDouble() ?? 0.0;

  int get quantity => _quantity;
}
