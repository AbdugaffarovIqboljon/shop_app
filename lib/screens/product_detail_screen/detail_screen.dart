import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/screens/product_detail_screen/product_detail_screen_views/add_to_cart_button.dart';
import 'package:shop_app/screens/product_detail_screen/product_detail_screen_views/added_to_cart_dialog.dart';
import 'package:shop_app/screens/product_detail_screen/product_detail_screen_views/build_tile.dart';
import 'package:shop_app/screens/product_detail_screen/product_detail_screen_views/product_description.dart';
import 'package:shop_app/services/cart_service/add_to_cart_service.dart';

import '../../data/network_service.dart';
import '../../model/product_model.dart';
import '../../model/special_offer.dart';
import '../../services/product_service.dart';

class ShopDetailScreen extends StatefulWidget {
  final int productId;

  const ShopDetailScreen({super.key, required this.productId});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  int _quantity = 0;
  late final List<SpecialOffer> datas = homeSpecialOffers;
  final NetworkService productService = NetworkService();
  List<ProductModel> productList = [];
  bool _isCollected = false;
  late double totalPrice;

  Future<void> saveProductToSqflite(ProductModel product, int quantity) async {
    final database = ProductDatabase();

    await database.open();
    bool containsProduct = await database.containsProduct(product.id);

    if (containsProduct) {
      await database.updateProductQuantity(
        productId: product.id,
        quantity: quantity,
      );
    } else {
      await database.insertProduct(product);
      await database.updateProductQuantity(
        productId: product.id,
        quantity: quantity,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    totalPrice = 0;
    _loadProductDetails();
  }

  Future<void> _loadProductDetails() async {
    try {
      final ProductModel product = await productService.methodGetProductById(
        productId: widget.productId,
      );

      setState(() {
        productList.add(product);
      });
    } catch (e) {
      print('Error fetching product details: $e');
    }
  }

  void addToCart(ProductModel product) {
    MyProvider.of(context).addToCart(
      product: product,
      quantity: _quantity,
    );

    saveProductToSqflite(product, _quantity);

    totalPrice > 0 ? showDelayedDialog(context) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 950.sp,
            child: ListView.builder(
              itemCount: productList.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                final product = productList[index];
                return Column(
                  children: [
                    Align(
                      alignment: Alignment(0.95.sp, 0),
                      child: IconButton(
                        onPressed: () =>
                            setState(() => _isCollected = !_isCollected),
                        icon: Image.asset(
                          'assets/icons/${_isCollected ? 'bold' : 'light'}/heart@2x.png',
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
                            product.price,
                          ),
                          const SizedBox(height: 15),
                          const Divider(color: Color(0xFFEEEEEE)),
                          const SizedBox(height: 15),
                          ...buildDescription(product.description),
                          SizedBox(height: 25.sp),
                          _buildQuantity(product),
                          SizedBox(height: 125.sp),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          /// #Add to Cart Button
          addToCartButton(
            totalPrice,
            () => addToCart(productList.first),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantity(ProductModel product) {
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
                  child: Image.asset(
                    'assets/icons/detail/minus@2x.png',
                    scale: 2,
                  ),
                  onTap: () {
                    if (_quantity <= 0) return;
                    setState(() => _quantity -= 1);
                    totalPrice > 0 ? totalPrice -= product.price : 0;
                  },
                ),
                const SizedBox(width: 20),
                Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  child: Image.asset(
                    'assets/icons/detail/plus@2x.png',
                    scale: 2,
                  ),
                  onTap: () {
                    setState(() => _quantity += 1);
                    totalPrice += product.price;
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
