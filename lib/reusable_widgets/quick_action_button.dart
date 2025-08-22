import 'package:flutter/material.dart';

class QuickActionButton extends StatelessWidget {
  final String labelLine1;
  final String labelLine2;
  final String iconPath; // The path to the PNG icon in assets
  final VoidCallback onPressed;

  const QuickActionButton({
    Key? key,
    required this.iconPath,
    required this.onPressed,
    required this.labelLine1,
    required this.labelLine2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150,
        //height: 60, // Use the passed width for the button
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF69CD10),
              Color.fromARGB(220, 133, 188, 85), // Start color
              Color.fromARGB(255, 76, 131, 27), // End color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //SizedBox(width: 16),
              Container(
                width: 24,
                child: Image.asset(
                  iconPath,
                  fit: BoxFit.contain,
                ),
              ),
              //SizedBox(width: 16),
              Center(
                child: Column(
                  children: [
                    Text(
                      labelLine1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      labelLine2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
