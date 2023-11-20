import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopDetailScreen extends StatefulWidget {
  const ShopDetailScreen({super.key});

  static String route() => '/shop_detail';

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  int _quantity = 0;
  bool _isCollected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true,
                expandedHeight: 280.sp,
                leading: IconButton(
                  icon: Image.asset('assets/icons/back@2x.png', scale: 2),
                  onPressed: () => Navigator.pop(context),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: const Color(0xFFeeeeee),
                    child: Image.asset(
                      'assets/icons/products/detail_sofa.png',
                      fit: BoxFit.none,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._buildTitle(),
                      const SizedBox(height: 16),
                      const Divider(color: Color(0xFFEEEEEE)),
                      const SizedBox(height: 16),
                      ..._buildDescription(),
                      const SizedBox(height: 24),
                      _buildQuantity(),
                      const SizedBox(height: 115),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _addToCartButton()
        ],
      ),
    );
  }

  List<Widget> _buildTitle() {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const FittedBox(
            child: Text(
              'Mid Century Sofa',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _isCollected = !_isCollected),
            icon: Image.asset(
              'assets/icons/${_isCollected ? 'bold' : 'light'}/heart@2x.png',
              height: 35.sp,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: Color(0xFFEEEEEE),
            ),
            child: Text(
              '9,742 sold',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.star_rate, color: Colors.orange),
          const SizedBox(width: 8),
          Text(
            '4.8 (6,573 reviews)',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> _buildDescription() {
    return [
      const Text(
        'Description',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      const ExpandableText(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit ametLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit ametLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit ametLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit ametLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit ametLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit ametLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit ametLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit ametLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit ametLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit ametLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit ametLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit ametLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit ametLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit ametLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et Lorem ipsum dolor sit amet',
        expandText: 'view more',
        collapseText: 'view less',
        textAlign: TextAlign.start,
        maxLines: 6,
        animation: true,
        animationCurve: ElasticInOutCurve(),
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        linkStyle: TextStyle(
          fontSize: 16,
          color: Color(0xFF424242),
          fontWeight: FontWeight.bold,
        ),
      ),
    ];
  }

  Widget _buildQuantity() {
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
                  child:
                      Image.asset('assets/icons/detail/minus@2x.png', scale: 2),
                  onTap: () {
                    if (_quantity <= 0) return;
                    setState(() => _quantity -= 1);
                  },
                ),
                const SizedBox(width: 20),
                Text('$_quantity',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                const SizedBox(width: 20),
                InkWell(
                  child:
                      Image.asset('assets/icons/detail/plus@2x.png', scale: 2),
                  onTap: () => setState(() => _quantity += 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _addToCartButton() {
    buildAddCard() => Container(
          height: 58.sp,
          width: 160.sp,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            color: const Color(0xFF101010),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 8),
                blurRadius: 20,
                color: const Color(0xFF101010).withOpacity(0.25),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/detail/bag@2x.png', scale: 2),
                  const SizedBox(width: 16),
                  const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            const Divider(color: Color(0xFFEEEEEE)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total price',
                      style: TextStyle(
                        color: const Color(0xFF757575),
                        fontSize: 13.sp,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$280.00',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                      ),
                    ),
                  ],
                ),
                buildAddCard()
              ],
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
