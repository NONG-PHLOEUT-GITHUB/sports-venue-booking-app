import 'package:flutter/material.dart';
import 'package:frontend/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onPressed,
    this.color = AppColors.primary,
    required this.text,
    this.colorBorder,
    this.textColor,
    this.height = 56,
    super.key,
  });

  final String text;
  final Color color;
  final VoidCallback onPressed;
  final Color? colorBorder;
  final Color? textColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Use the provided color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
        side: colorBorder != null
            ? BorderSide(color: colorBorder!)
            : BorderSide.none,
      ),
      onPressed: onPressed,
      child: Text(
        text, // Use the text parameter
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor ??
              AppColors.onSecondary, // Use provided textColor or default
        ),
      ),
    );
  }
}
