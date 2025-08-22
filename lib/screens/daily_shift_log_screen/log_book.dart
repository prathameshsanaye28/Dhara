import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhara_sih/reusable_widgets/reusable_scaffold.dart';
import 'package:dhara_sih/screens/daily_shift_log_screen/daily_shift_log_screen.dart';
import 'package:dhara_sih/screens/daily_shift_log_screen/dynamic_daily_shift_log.dart';
import 'package:flutter/material.dart';

class LogBookScreen extends StatelessWidget {
  const LogBookScreen({Key? key}) : super(key: key);

  Future<List<String>> _fetchTemplates(String collectionName) async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();
      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      debugPrint("Error fetching templates from $collectionName: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(
      showBars: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Shift Logs",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<String>>(
                future: _fetchTemplates('shiftLogs'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No Shift Logs Found"),
                    );
                  }

                  final templates = snapshot.data!;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: templates.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.folder, color: Colors.blue),
                          title: Text("Template ${index + 1}"),
                          subtitle: Text(templates[index]),
                          onTap: () {
                            // Handle tile click
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DailyShiftLogScreen(),),);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              const Text(
                "Dynamic Shift Logs",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<String>>(
                future: _fetchTemplates('dynamicShiftLogs'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No Dynamic Shift Logs Found"),
                    );
                  }

                  final templates = snapshot.data!;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: templates.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.folder, color: Colors.green),
                          title: Text("Template ${index + 1}"),
                          subtitle: Text(templates[index]),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DynamicDailyShiftLogScreen(),),);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}