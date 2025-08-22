import 'package:flutter/material.dart';

class CustomGreenButton extends StatelessWidget {
  final String label;
  const CustomGreenButton({super.key, required this.label});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          const Color.fromARGB(255, 20, 57, 21),
          const Color.fromARGB(255, 29, 83, 31),
          const Color.fromARGB(255, 43, 118, 46),
          const Color.fromARGB(255, 66, 163, 69),
          const Color.fromARGB(255, 66, 163, 69),
          const Color.fromARGB(255, 66, 163, 69),
        ]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15
          ),),
        ],
      ),
    );
  }
}