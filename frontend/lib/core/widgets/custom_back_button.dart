import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double borderWidth;

  const CustomBackButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.borderWidth = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.dividerColor.withOpacity(0.4),
            width: borderWidth,
          ),
          shape: BoxShape.circle,
          color: backgroundColor ?? theme.colorScheme.surface,
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: iconColor ?? theme.iconTheme.color,
          ),
          onPressed: onPressed ?? () => Navigator.pop(context),
        ),
      ),
    );
  }
}
