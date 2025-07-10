import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool fullWidth;
  final IconData? icon;
  final bool isLoading;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? iconColor;
  final bool isOutlined;

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.fullWidth = false,
    this.icon,
    this.isLoading = false,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.iconColor,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconActualColor = iconColor ?? foregroundColor;
    final buttonChild = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          )
        : (icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 20, color: iconActualColor),
                    const SizedBox(width: 8),
                    Text(label, style: TextStyle(color: foregroundColor)),
                  ],
                )
              : Text(label, style: TextStyle(color: foregroundColor)));

    final style = isOutlined
        ? OutlinedButton.styleFrom(
            foregroundColor: foregroundColor,
            side: BorderSide(color: foregroundColor),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            side: backgroundColor == Colors.white
                ? const BorderSide(color: Colors.black)
                : null,
          );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: style,
              child: buttonChild,
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: style,
              child: buttonChild,
            ),
    );
  }
}
