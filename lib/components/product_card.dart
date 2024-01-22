import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/model/product_model.dart';

import '../services/cart_service/add_to_cart_service.dart';

class ProductCard extends StatefulWidget {
  final BorderRadius borderRadius;
  final ProductModel product;
  final void Function() onTap;

  const ProductCard({
    super.key,
    required this.borderRadius,
    required this.product,
    required this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: const Alignment(1.2, 0),
              child: IconButton(
                iconSize: 25.sp,
                onPressed: () {},
                icon: const Icon(CupertinoIcons.heart),
              ),
            ),
            Center(
              child: Image.network(
                widget.product.image,
                height: 160.sp,
              ),
            ),
            SizedBox(height: 20.sp),
            Text(
              widget.product.title,
              style: TextStyle(
                color: const Color(0xFF212121),
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 15.sp),
            Row(
              children: [
                Icon(
                  Icons.star_rate,
                  color: Colors.orange,
                  size: 20.sp,
                ),
                const SizedBox(width: 8),
                Text(
                  '${widget.product.rating.rate}',
                  style: TextStyle(
                    color: const Color(0xFF616161),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                    color: Colors.deepPurpleAccent,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 3,
                  ),
                  child: Text(
                    '${widget.product.rating.count} left',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${widget.product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF212121),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    MyProvider.of(context).addToCart(
                      product: widget.product,
                      quantity: 1,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 600),
                        content: Center(
                          child: Text(
                            "Successfully Added to your Cart",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    CupertinoIcons.cart_badge_plus,
                    size: 28.sp,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
