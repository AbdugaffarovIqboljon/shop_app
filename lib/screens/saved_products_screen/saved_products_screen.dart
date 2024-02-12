import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/services/product_database.dart';

import '../../providers/cart_provider.dart';

class SavedProductsScreen extends StatelessWidget {
  const SavedProductsScreen({Key? key}) : super(key: key);

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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<ProductModel> likedProducts = snapshot.data ?? [];
            return ListView.builder(
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              itemCount: likedProducts.length,
              itemBuilder: (context, index) {
                final likedProduct = likedProducts[index];
                final isSelected =
                    CartProvider().selectedProducts.contains(likedProduct);
                return Container(
                  height: 120.sp,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color:
                        isSelected ? Colors.grey.shade100 : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: isSelected
                          ? Colors.grey.shade500
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Center(
                    child: ListTile(
                      splashColor: Colors.transparent,
                      onTap: () {
                        CartProvider()
                            .toggleProductSelection(product: likedProduct);
                      },
                      minLeadingWidth: 50.sp,
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
          }
        },
      ),
    );
  }
}
