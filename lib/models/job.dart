// import 'package:cloud_firestore/cloud_firestore.dart';

// class Job {
//   String? id;
//   String title;
//   String description;
//   String priority;
//   DateTime? end; // End date
//   String? mineManager; // Reference to a `mineManager` document ID
//   String? shiftIncharge; // Reference to a `shiftIncharge` document ID
//   String? team; // Reference to a `team` document ID
//   String status;

//   Job({
//     this.id,
//     required this.title,
//     required this.description,
//     required this.priority,
//     this.end,
//     this.mineManager,
//     this.shiftIncharge,
//     this.team,
//     this.status = 'Pending',
//   });

//   // Convert a Firestore document to a Job instance
//   factory Job.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

//     return Job(
//       id: doc.id,
//       title: data['title'] ?? '',
//       description: data['description'] ?? '',
//       priority: data['priority'] ?? '',
//       end: data['end'] != null ? (data['end'] as Timestamp).toDate() : null,
//       mineManager: data['mineManager'],
//       shiftIncharge: data['shiftIncharge'],
//       team: data['team'],
//       status: data['status'] ?? 'Pending',
//     );
//   }

//   // Convert a Job instance to a Firestore document
//   Map<String, dynamic> toFirestore() {
//     return {
//       'title': title,
//       'description': description,
//       'priority': priority,
//       'end': end != null ? Timestamp.fromDate(end!) : null,
//       'mineManager': mineManager,
//       'shiftIncharge': shiftIncharge,
//       'team': team,
//       'status': status,
//     };
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  final String? id;
  final String title;
  final String description;
  final String priority;
  final DateTime? end; // End date
  final String? mineManager; // Reference to a `mineManager` document ID
  final String? shiftIncharge; // Reference to a `shiftIncharge` document ID
  final String? team; // Reference to a `team` document ID
  final String status;

  const Job({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    this.end,
    this.mineManager,
    this.shiftIncharge,
    this.team,
    this.status = 'Pending',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'priority': priority,
        'end': end != null ? Timestamp.fromDate(end!) : null,
        'mineManager': mineManager,
        'shiftIncharge': shiftIncharge,
        'team': team,
        'status': status,
      };

  static Job fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Job(
      id: snap.id,
      title: snapshot['title'] ?? '',
      description: snapshot['description'] ?? '',
      priority: snapshot['priority'] ?? '',
      end: snapshot['end'] != null ? (snapshot['end'] as Timestamp).toDate() : null,
      mineManager: snapshot['mineManager'],
      shiftIncharge: snapshot['shiftIncharge'],
      team: snapshot['team'],
      status: snapshot['status'] ?? 'Pending',
    );
  }

  Job copyWithStatus(String newStatus) {
    return Job(
      id: id,
      title: title,
      description: description,
      priority: priority,
      end: end,
      mineManager: mineManager,
      shiftIncharge: shiftIncharge,
      team: team,
      status: newStatus,
    );
  }
}