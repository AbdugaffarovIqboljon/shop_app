import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/network_service.dart';
import '../../../model/category.dart';
import '../../../model/product_model.dart';

class ByCategoriesWidget extends StatefulWidget {
  final Function(int) onCategorySelected;

  const ByCategoriesWidget({super.key, required this.onCategorySelected});

  @override
  State<ByCategoriesWidget> createState() => _ByCategoriesWidgetState();
}

class _ByCategoriesWidgetState extends State<ByCategoriesWidget> {
  int selectIndex = 0;
  final NetworkService productService = NetworkService();
  List<ProductModel> productList = [];

  Future<void> fetchAllData() async {
    try {
      List<ProductModel> fetchedProducts =
          await productService.methodGetAllProducts();
      setState(() {
        productList = fetchedProducts;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    late final List<Category> categories = homeCategories;

    return Column(
      children: [
        SizedBox(
          height: 100.sp,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: categories.length,
            padding: REdgeInsets.symmetric(horizontal: 5),
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              final response = categories[index];
              final isActive = selectIndex == index;
              return GestureDetector(
                onTap: () => _onTapItem(index),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      height: 50.sp,
                      width: 120.sp,
                      decoration: BoxDecoration(
                        color: isActive
                            ? Colors.deepPurple.shade700
                            : const Color(0xFFF7F8FB),
                        border: Border.all(
                          color: isActive ? Colors.transparent : Colors.black12,
                        ),
                        boxShadow: [
                          isActive
                              ? BoxShadow(
                                  color: Colors.deepPurpleAccent.shade100,
                                  offset: const Offset(2, 2),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                )
                              : const BoxShadow(),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          response.title,
                          style: TextStyle(
                            color: isActive == false
                                ? Colors.deepPurpleAccent
                                : const Color(0xffffffff),
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 20.sp);
            },
          ),
        ),
      ],
    );
  }

  void _onTapItem(int index) {
    setState(() {
      selectIndex = index;
    });

    widget.onCategorySelected(selectIndex);
  }
}
