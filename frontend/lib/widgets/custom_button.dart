import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? color;
  final String text;
  final Color? colorBorder;
  final Color? textColor;
  final double height;

  const CustomButton({
    required this.onPressed,
    this.color, // no default here
    required this.text,
    this.colorBorder,
    this.textColor,
    this.height = 56,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = Get.theme.colorScheme.onSecondary;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        minimumSize: Size(double.infinity, height),
        side: colorBorder != null ? BorderSide(color: colorBorder!) : null,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}

