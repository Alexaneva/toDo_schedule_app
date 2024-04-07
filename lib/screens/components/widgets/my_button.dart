import 'package:flutter/material.dart';

import '../theme.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: pinkClr,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.add, size: 15, color: Colors.white),
      ),
    );
  }
}
