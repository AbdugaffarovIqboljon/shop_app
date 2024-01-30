import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../model/product_model.dart';
import '../cart_screen.dart';

Widget buildListView(
  BuildContext context,
  List<ProductModel> products,
  void Function()? onPressed,
) {
  return ListView.builder(
    clipBehavior: Clip.antiAlias,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
    itemCount: products.length,
    itemBuilder: (context, index) {
      final product = products[index];
      final cartProvider = Provider.of<CartProvider>(context);
      final isSelected = cartProvider.selectedProducts.contains(product);

      return Container(
        height: 120.sp,
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
            splashColor: Colors.transparent,
            onTap: () {
              cartProvider.toggleProductSelection(product: product);
            },
            minLeadingWidth: 50.sp,
            leading: Image(
              height: 80.sp,
              width: 80.sp,
              image: NetworkImage(product.image),
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
                IconButton(
                  onPressed: onPressed,
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
