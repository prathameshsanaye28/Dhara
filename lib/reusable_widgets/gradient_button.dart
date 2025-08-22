import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double fontSize;
  final double borderRadius;

  const GradientButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.fontSize,
    this.borderRadius = 15, // Default to 15 if no borderRadius is passed
  }) : super(key: key);

  static const List<Color> gradientColors = [
    Color.fromRGBO(16, 38, 4, 1), // Start color
    Color.fromRGBO(69, 126, 15, 1), // End color
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
