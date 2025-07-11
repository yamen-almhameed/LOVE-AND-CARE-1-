import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class IconPinkBack extends StatelessWidget {
  final double width;
  final double height;
  const IconPinkBack({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color(0xFFf66890),
          shape: BoxShape.circle,
          border: Border.all(color: Color(0xFFf7cdcf), width: 8),
        ),
        child: Center(
          child: Icon(Icons.keyboard_arrow_left, size: 40, color: Colors.white),
        ),
      ),
      onTap: () {
        Get.back();
      },
    );
  }
}
