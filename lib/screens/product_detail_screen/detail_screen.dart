import 'package:shop_app/library.dart';
import 'package:shop_app/providers/shop_detail_provider.dart';
import 'package:shop_app/screens/product_detail_screen/product_detail_screen_views/added_to_cart_dialog.dart';
import 'package:shop_app/screens/product_detail_screen/product_detail_screen_views/build_product_quantity.dart';
import 'package:shop_app/screens/product_detail_screen/product_detail_screen_views/build_tile.dart';
import 'package:shop_app/screens/product_detail_screen/product_detail_screen_views/product_description.dart';
import 'package:shop_app/screens/product_detail_screen/product_detail_screen_views/product_detail_skeleton.dart';

class ShopDetailScreen extends StatefulWidget {
  final int productId;

  const ShopDetailScreen({super.key, required this.productId});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  LocalDatabase localDatabase = LocalDatabase();

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
                      return const Center(
                        child: Text(
                          "Some error has been occured :( \nPlease Try Again later!",
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return buildSkeletonDetail();
                    } else {
                      final product = snapshot.data!;
                      return SingleChildScrollView(
                        primary: true,
                        child: Consumer<LikedProductsProvider>(
                          builder: (context, likedProductsProvider, child) {
                            bool isLiked = likedProductsProvider.likedProducts
                                .contains(product);
                            return Column(
                              children: [
                                SizedBox(height: 50.sp),
                                Align(
                                  alignment: Alignment(0.95.sp, 0),
                                  child: IconButton(
                                    onPressed: () {
                                      likedProductsProvider.toggleLike(product);
                                    },
                                    icon: Image.asset(
                                      'assets/icons/${isLiked ? 'bold' : 'light'}/heart@2x.png',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      BuildQuantity(
                                        shopDetailProvider: shopDetailProvider,
                                      ),
                                      SizedBox(height: 125.sp),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
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
