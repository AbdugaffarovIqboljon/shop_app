import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/providers/liked_products_provider.dart';
import 'package:shop_app/screens/product_detail_screen/detail_screen.dart';
import 'package:shop_app/data/services/database/product_database.dart';

class SavedProductsScreen extends StatefulWidget {
  const SavedProductsScreen({super.key});

  @override
  State<SavedProductsScreen> createState() => _SavedProductsScreenState();
}

class _SavedProductsScreenState extends State<SavedProductsScreen> {
  void navigateToShopDetailScreen() {}

  @override
  Widget build(BuildContext context) {
    LocalDatabase localDatabase = LocalDatabase();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Saved Products',
          style: TextStyle(
            fontSize: 23.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: localDatabase.getLikedProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Some error has been occured :(',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            );
          } else {
            List<ProductModel> likedProducts = snapshot.data ?? [];
            return ListView.builder(
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              itemCount: likedProducts.length,
              itemBuilder: (context, index) {
                final likedProduct = likedProducts[index];
                return Consumer<LikedProductsProvider>(
                  builder: (context, value, child) {
                    bool isLiked = value.likedProducts.contains(likedProduct);
                    return Container(
                      height: 120.sp,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: ListTile(
                          splashColor: Colors.transparent,
                          minLeadingWidth: 50.sp,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShopDetailScreen(
                                  productId: likedProduct.id,
                                ),
                              ),
                            );
                          },
                          leading: Image(
                            height: 80.sp,
                            width: 80.sp,
                            image: NetworkImage(likedProduct.image),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  likedProduct.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  value.toggleLike(likedProduct);
                                  setState(() {});
                                },
                                icon: Image.asset(
                                  'assets/icons/${isLiked ? 'bold' : 'light'}/heart@2x.png',
                                  height: 28.sp,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            "Price: \$${likedProduct.price}",
                            style: TextStyle(
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
