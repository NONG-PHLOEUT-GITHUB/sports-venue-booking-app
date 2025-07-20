import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double borderWidth;

  const CustomBackButton({
    Key? key,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.borderWidth = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: borderWidth),
          shape: BoxShape.circle,
          color: Get.theme.colorScheme.surface,
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onPressed ?? () => Navigator.pop(context),
        ),
      ),
    );
  }
}
