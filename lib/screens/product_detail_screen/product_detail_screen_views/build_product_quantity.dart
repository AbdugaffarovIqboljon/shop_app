import 'package:flutter/material.dart';
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
                    if (widget.shopDetailProvider.quantity <= 0) return;
                    widget.shopDetailProvider.updateQuantity(
                      widget.shopDetailProvider.quantity - 1,
                    );
                  },
                ),
                const SizedBox(width: 20),
                Text(
                  '${widget.shopDetailProvider.quantity}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  child: const Icon(Icons.add),
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
