import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double width;
  final double height;
  final double verticalPadding;
  final double horizontalPadding;
  final Widget child;

  const CustomContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.verticalPadding,
    required this.horizontalPadding,
    required this.child, // This is the content inside the container
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(233, 234, 230, 0.20),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
