import 'package:dhara_sih/reusable_widgets/reusable_scaffold.dart';
import 'package:flutter/material.dart';

import '../../reusable_widgets/reusable_glassmorphic_container.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(
      showBars: true,
      body: GlassEffectContainer(
        width: double.infinity,
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.warning, color: Colors.red),
                  const SizedBox(width: 10),
                  const Text(
                    "Active Alerts",
                    style: TextStyle(
                      fontSize: 16, // Reduced size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildHeader("Alert Type"),
                  _buildHeader("Severity"),
                  _buildHeader("Location"),
                  _buildHeader("Timestamp"),
                  _buildHeader("Actions"),
                ],
              ),
              const SizedBox(height: 15),
              _buildRowItem(
                  "High Methane", "Critical", "Section B", "12:35 PM"),
              const Divider(color: Colors.white, thickness: 0.25),
              const SizedBox(height: 15),
              _buildRowItem("High Methane", "Warning", "Section B", "12:35 PM"),
              const Divider(color: Colors.white, thickness: 0.25),
              const SizedBox(height: 15),
              _buildRowItem("High Methane", "Warning", "Section B", "12:35 PM"),
              const Divider(color: Colors.white, thickness: 0.25),
              const SizedBox(height: 15),
              _buildRowItem(
                  "High Methane", "Critical", "Section B", "12:35 PM"),
              const Divider(color: Colors.white, thickness: 0.25),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String text) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 65,
      decoration: BoxDecoration(
        color: const Color.fromARGB(105, 103, 102, 102),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontSize: 12), // Smaller size
      ),
    );
  }

  Widget _buildRowItem(
      String alertType, String severity, String location, String timestamp) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          alertType,
          style: const TextStyle(
              color: Colors.white, fontSize: 10), // Smaller size
        ),
        Container(
          alignment: Alignment.center,
          width: 60,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: severity == "Critical"
                ? Colors.red
                : severity == "Warning"
                    ? Colors.orange
                    : Colors.green,
          ),
          child: Text(
            severity,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          location,
          style: const TextStyle(
              color: Colors.white, fontSize: 10), // Smaller size
        ),
        Text(
          timestamp,
          style: const TextStyle(
              color: Colors.white, fontSize: 10), // Smaller size
        ),
        Container(
          width: 70,
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 58, 82, 239),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "Investigate",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10, // Smaller size
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
