import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassEffectContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Widget child;

  const GlassEffectContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: width,
      height: height,
      borderRadius: borderRadius,
      blur: 20,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        colors: [
          const Color.fromARGB(255, 36, 35, 50).withOpacity(0.4),
          Colors.black.withOpacity(0.05),
          const Color.fromARGB(255, 36, 35, 50).withOpacity(0.4),
          //Colors.white,
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderGradient: LinearGradient(
        colors: [
          Color(0xFF467510).withOpacity(1),
          Colors.transparent,
          Color(0xFF467510).withOpacity(1),
        ],
        begin: Alignment.topRight, // Start the gradient at the top-right
        end: Alignment.bottomLeft, // End the gradient at the bottom-left
        // Ensure smooth transition across the gradient
      ),
      child: child,
    );
  }
}