import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final bool isOutlined;

  const MyButton({
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textColor,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return isOutlined
        ? OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: textColor),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: onPressed,
            child: Text(text, style: TextStyle(color: textColor, fontSize: 16)),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: onPressed,
            child: Text(text, style: TextStyle(color: textColor, fontSize: 16)),
          );
  }
}

