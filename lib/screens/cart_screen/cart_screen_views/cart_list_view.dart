import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/data/services/database/product_database.dart';
import 'package:shop_app/screens/product_detail_screen/detail_screen.dart';

import '../../../model/product_model.dart';
import '../../../providers/cart_provider.dart';

class CartListView extends StatelessWidget {
  final List<ProductModel> products;
  final void Function(ProductModel) onPressed;

  const CartListView({
    super.key,
    required this.products,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      shrinkWrap: true,
      clipBehavior: Clip.antiAlias,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final cartProvider = Provider.of<CartProvider>(context);
        final isSelected = cartProvider.selectedProducts.contains(product);
        LocalDatabase localDatabase = LocalDatabase();
        return Container(
          height: 110.sp,
          margin: const EdgeInsets.symmetric(vertical: 8),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: isSelected ? Colors.grey.shade100 : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: isSelected ? Colors.grey.shade500 : Colors.grey.shade300,
            ),
          ),
          child: Center(
            child: ListTile(
              selected: isSelected,
              tileColor: isSelected ? Colors.grey.shade100 : Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                cartProvider.toggleProductSelection(product: product);
              },
              minLeadingWidth: 50.sp,
              leading: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopDetailScreen(
                        productId: product.id,
                      ),
                    ),
                  );
                },
                child: Image(
                  height: 80.sp,
                  width: 80.sp,
                  image: NetworkImage(product.image),
                ),
              ),
              title: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price: \$${product.price}",
                    style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  FutureBuilder<int>(
                    future: localDatabase.getProductQuantity(product.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text("No Data :(");
                      } else {
                        int quantity = snapshot.data ?? 0;
                        return Text(
                          'Quantity: $quantity',
                          style: TextStyle(
                            fontSize: 15.5.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }
                    },
                  ),
                  IconButton(
                    onPressed: () => onPressed(product),
                    icon: const Icon(Icons.delete_rounded),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
