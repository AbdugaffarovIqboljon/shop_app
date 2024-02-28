import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/providers/shop_detail_provider.dart';

class BuildQuantity extends StatefulWidget {
  final ShopDetailProvider shopDetailProvider;

  const BuildQuantity({
    super.key,
    required this.shopDetailProvider,
  });

  @override
  State<BuildQuantity> createState() => _BuildQuantityState();
}

class _BuildQuantityState extends State<BuildQuantity> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Quantity',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        const SizedBox(width: 20),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24.r)),
            color: const Color(0xFFF3F3F3),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                InkWell(
                  child: Icon(
                    Icons.remove,
                    size: 23.sp,
                  ),
                  onTap: () {
                    if (widget.shopDetailProvider.quantity <= 0) return;
                    widget.shopDetailProvider.updateQuantity(
                      widget.shopDetailProvider.quantity - 1,
                    );
                  },
                ),
                const SizedBox(width: 15),
                Text(
                  '${widget.shopDetailProvider.quantity}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                const SizedBox(width: 15),
                InkWell(
                  child: Icon(
                    Icons.add,
                    size: 23.sp,
                  ),
                  onTap: () => widget.shopDetailProvider.updateQuantity(
                    widget.shopDetailProvider.quantity + 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
