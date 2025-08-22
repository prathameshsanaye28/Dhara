import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhara_sih/models/equipment.dart';
import 'package:dhara_sih/reusable_widgets/reusable_glassmorphic_container.dart';
import 'package:dhara_sih/reusable_widgets/reusable_scaffold.dart';
import 'package:flutter/material.dart';

class EquipmentListScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch equipment data from Firestore
  Stream<List<Equipment>> fetchEquipments() {
    return _firestore.collection('equipments').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Equipment(
          name: data['name'],
          status: data['status'],
          priority: data['priority'],
        );
      }).toList();
    });
  }

  // Map priority to tile color
  Color getTileColor(String priority) {
    switch (priority) {
      case 'low':
        return const Color(0xFFD3FFBD).withOpacity(0.84); // Light green
      case 'medium':
        return const Color(0xFFFFE88A).withOpacity(0.84); // Yellow
      case 'high':
        return const Color(0xFFFFC1B8); // Red (100%)
      default:
        return Colors.white; // Default color
    }
  }

  // Map priority to icon
  IconData getPriorityIcon(String priority) {
    switch (priority) {
      case 'low':
        return Icons.check_circle_outline; // Low priority
      case 'medium':
        return Icons.warning_amber_rounded; // Medium priority
      case 'high':
        return Icons.error; // High priority
      default:
        return Icons.info_outline; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(
      showBars: true,
      body: Center(
        child: Column(
          children: [
            Text(
              'Equipment List',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 16),
            GlassEffectContainer(
              width: double.infinity,
              height: 600,
              child: StreamBuilder<List<Equipment>>(
                stream: fetchEquipments(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading data.'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No equipment found.'));
                  }

                  final equipments = snapshot.data!;
                  return ListView.builder(
                    itemCount: equipments.length,
                    itemBuilder: (context, index) {
                      final equipment = equipments[index];
                      return Card(
                        color: getTileColor(equipment.priority),
                        child: ListTile(
                          leading: Icon(
                            getPriorityIcon(equipment.priority),
                            color: Colors.black54,
                          ),
                          title: Text(
                            equipment.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(equipment.status),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}