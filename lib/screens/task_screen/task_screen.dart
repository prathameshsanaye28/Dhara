import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../reusable_widgets/reusable_glassmorphic_container.dart';
import '../../reusable_widgets/reusable_scaffold.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return ReusableScaffold(
      showBars: true,
      body: Center(
        child: Column(
          children: [
            Text(
              'Tasks',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 16),
            GlassEffectContainer(
              width: double.infinity,
              height: 600,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('jobs')
                    .snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> jobSnapshot) {
                  if (jobSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final jobDocs = jobSnapshot.data?.docs;

                  return ListView.builder(
                    itemCount: jobDocs?.length,
                    itemBuilder: (ctx, index) {
                      final jobData = jobDocs?[index];
                      final priorityColor = getTileColor(jobData?['priority']);

                      return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('mineManagers')
                            .doc(jobData?['mineManager'])
                            .get(),
                        builder: (ctx,
                            AsyncSnapshot<DocumentSnapshot> managerSnapshot) {
                          if (managerSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final managerData = managerSnapshot.data;

                          return Card(
                            color: priorityColor,
                            margin: EdgeInsets.all(10),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    jobData?['title'] ?? '',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    jobData?['description'] ?? '',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Assigned by: ${managerData?['name'] ?? ''}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Text(
                                        'Priority: ${jobData?['priority'] ?? ''}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () =>
                                            _uploadProof(jobData?.id),
                                        child: Text('Upload Proof'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => _markAsDone(context,
                                            jobData?.id, jobData?['proofUrl']),
                                        child: Text(jobData?['status'] ==
                                                'confirmation pending'
                                            ? 'Validating'
                                            : 'Mark as Done'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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

  Color getTileColor(String priority) {
    switch (priority) {
      case 'high':
        return const Color(0xFFFFC1B8); // Red (100%)
      case 'medium':
        return const Color(0xFFFFE88A).withOpacity(0.84); // Yellow
      case 'low':
        return const Color(0xFFD3FFBD).withOpacity(0.84); // Light green
      default:
        return Colors.white; // Default color
    }
  }

  Future<void> _uploadProof(String? jobId) async {
    if (jobId == null) return;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // Upload the file to Firebase Storage and get the URL
      // Update the job document with the proof URL and set status to 'confirmation pending'
      FirebaseFirestore.instance.collection('jobs').doc(jobId).update({
        'status': 'confirmation pending',
        'proofUrl': 'url_of_uploaded_file', // Replace with actual URL
      });
    }
  }

  Future<void> _markAsDone(
      BuildContext context, String? jobId, String? proofUrl) async {
    if (jobId == null) return;
    if (proofUrl == null || proofUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please upload proof before marking as done.')),
      );
      return;
    }
    // Update the job document to mark it as done
    FirebaseFirestore.instance.collection('jobs').doc(jobId).update({
      'status': 'confirmation pending',
    });
  }
}