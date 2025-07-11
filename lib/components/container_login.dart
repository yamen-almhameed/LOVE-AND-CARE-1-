import 'package:flutter/material.dart';

class ContainerLogin extends StatelessWidget {
  final String title;
  const ContainerLogin({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xFFF66890),
      ),
      height: 48,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Inter_18pt',
          ),
        ),
      ),
    );
  }
}
