import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/category.dart';

class ByCategoriesWidget extends StatefulWidget {
  const ByCategoriesWidget({super.key});

  @override
  State<ByCategoriesWidget> createState() => _ByCategoriesWidgetState();
}

class _ByCategoriesWidgetState extends State<ByCategoriesWidget> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    late final List<Category> categories = homeCategories;

    return Column(
      children: [
        SizedBox(
          height: 130.sp,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              final response = categories[index];
              final isActive = _selectIndex == index;
              return GestureDetector(
                onTap: () => _onTapItem(index),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: isActive
                            ? Colors.deepPurple.shade100
                            : const Color(0xFFFFFFFF),
                        border: Border.all(color: Colors.deepPurpleAccent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.asset(
                          response.icon,
                          width: 28.sp,
                          height: 28.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.sp),
                    Text(
                      response.title,
                      style: const TextStyle(
                        color: Color(0xff424242),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
      _selectIndex = index;
    });
  }
}
