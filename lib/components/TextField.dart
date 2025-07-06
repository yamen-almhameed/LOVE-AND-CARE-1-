import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final RxBool ShowIcon;
  final RxBool? visibility;
  final VoidCallback? toggleVisibility;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.ShowIcon,
    this.visibility,
    this.toggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextField(
        controller: controller,
        obscureText: ShowIcon.value ? !(visibility?.value ?? false) : false,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: ShowIcon.value
              ? IconButton(
                  icon: Icon(
                    (visibility?.value ?? false)
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: toggleVisibility,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
