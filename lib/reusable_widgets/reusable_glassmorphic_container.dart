import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassEffectContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const GlassEffectContainer({
    super.key,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: width,
      height: height,
      borderRadius: 20,
      blur: 20,
      alignment: Alignment.center,
      border: 0.5,
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
          const Color(0xFF467510).withOpacity(1),
          Colors.transparent,
          const Color(0xFF467510).withOpacity(1),
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      child: child,
    );
  }
}
