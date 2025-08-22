import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType; // Optional keyboardType parameter

  const ReusableTextField({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType, // Accepting keyboardType as an optional parameter
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType, // Pass the keyboardType to the TextField
      style: const TextStyle(
        color: Colors.white54,
        fontSize: 14, // Adjusted font size for better readability
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54, fontSize: 14),
        filled: true,
        fillColor: const Color.fromRGBO(233, 234, 230, 0.17),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 6, horizontal: 12), // Reduced vertical padding
      ),
    );
  }
}
