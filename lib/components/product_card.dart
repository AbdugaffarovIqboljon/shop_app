import 'package:flutter/cupertino.dart';
import 'package:shop_app/library.dart';

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
  LocalDatabase localDatabase = LocalDatabase();
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<LikedProductsProvider>(
      builder: (BuildContext context, likedProductsProvider, Widget? child) {
        bool isLiked =
            likedProductsProvider.likedProducts.contains(widget.product);
        return InkWell(
          borderRadius: widget.borderRadius,
          onTap: widget.onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
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
                    onPressed: () {
                      likedProductsProvider.toggleLike(widget.product);
                    },
                    icon: Image.asset(
                      'assets/icons/${isLiked ? 'bold' : 'light'}/heart@2x.png',
                      height: 28.h,
                    ),
                  ),
                ),
                Center(
                  child: Image.network(
                    widget.product.image,
                    height: 160.h,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  widget.product.title,
                  style: TextStyle(
                    color: const Color(0xFF212121),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 15.h),
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
                SizedBox(height: 8.h),
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
                        quantity++;
                        localDatabase.saveData(
                          product: widget.product,
                          quantity: quantity,
                        );
                        quantity = 0;
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
      },
    );
  }
}
