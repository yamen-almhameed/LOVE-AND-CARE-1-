import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBackButton extends StatelessWidget {
  const BottomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          color: const Color(0xFFf6ecdf),
        ),
        Positioned(
          top: -30,
          child: InkWell(
            onTap: () => Get.back(),
            child: Container(
              width: 70,
              height: 65,
              decoration: BoxDecoration(
                color: const Color(0xFFf66890),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFf7cdcf), width: 8),
              ),
              child: const Icon(
                Icons.keyboard_arrow_left,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
