import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final double borderWidth;

  const CustomBackButton({
    Key? key,
    this.onPressed,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
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
          color: backgroundColor,
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: iconColor),
          onPressed: onPressed ?? () => Navigator.pop(context),
        ),
      ),
    );
  }
}
