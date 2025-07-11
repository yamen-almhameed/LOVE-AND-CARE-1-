import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final RxBool showIcon;
  final RxBool? visibility;
  final VoidCallback? toggleVisibility;
  final bool hintStyle;
  final bool filled;
  final bool filledColor;
  final bool outInputBorder;
  final bool limitToFour;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.showIcon,
    this.visibility,
    this.toggleVisibility,
    this.hintStyle = false,
    this.filled = false,
    this.filledColor = false,
    this.outInputBorder = false,
    this.limitToFour = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextField(
        controller: controller,
        obscureText: showIcon.value ? !(visibility?.value ?? false) : false,
        inputFormatters: limitToFour
            ? [LengthLimitingTextInputFormatter(4)]
            : [],
        decoration: InputDecoration(
          filled: filled,
          fillColor: filledColor ? Color(0xFFE4E4E4) : null,
          hintText: hintText,
          hintStyle: hintStyle
              ? GoogleFonts.inter(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )
              : null,
          suffixIcon: showIcon.value
              ? IconButton(
                  icon: Icon(
                    (visibility?.value ?? false)
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: toggleVisibility,
                )
              : null,
          border: outInputBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
