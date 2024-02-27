import 'package:shop_app/library.dart';

class SpecialOfferWidget extends StatefulWidget {
  final SpecialOffer data;
  final BuildContext context;
  final int index;
  final ProductModel productModel;

  const SpecialOfferWidget(
    this.context, {
    super.key,
    required this.data,
    required this.index,
    required this.productModel,
  });

  @override
  State<SpecialOfferWidget> createState() => _SpecialOfferWidgetState();
}

class _SpecialOfferWidgetState extends State<SpecialOfferWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.sp),
                Text(
                  widget.data.discount,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 35.sp,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.productModel.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.productModel.description,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13.5.sp,
                    color: Colors.black,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Align(
            alignment: const Alignment(0.6, 0),
            child: CachedNetworkImage(
              imageUrl: widget.productModel.image,
              height: 160.sp,
            ),
          ),
        ),
      ],
    );
  }
}
