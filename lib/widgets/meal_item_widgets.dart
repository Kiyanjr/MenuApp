import 'package:flutter/material.dart';


class MealItemWidget extends StatelessWidget {
  const MealItemWidget({super.key, required this.icon, required this.lable});

  final IconData icon;
  final String lable;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white),
        SizedBox(height: 6),
        Text(lable, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
