import 'package:flutter/material.dart';

class ByCategoriesTitle extends StatelessWidget {
  const ByCategoriesTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'By Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF212121),
          ),
        ),
        Icon(Icons.sort_rounded),
      ],
    );
  }
}
