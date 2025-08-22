// import 'package:cloud_firestore/cloud_firestore.dart';

// class Task {
//   String? id;
//   String title;
//   String description;
//   String type;
//   String priority;
//   DateTime? start; // Start date
//   DateTime? end; // End date
//   String? mineManager; // Reference to a `mineManager` document ID
//   bool completed;

//   Task({
//     this.id,
//     required this.title,
//     required this.description,
//     required this.type,
//     required this.priority,
//     this.start,
//     this.end,
//     this.mineManager,
//     this.completed = false,
//   });

//   // Convert a Firestore document to a Task instance
//   factory Task.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

//     return Task(
//       id: doc.id,
//       title: data['title'] ?? '',
//       description: data['description'] ?? '',
//       type: data['type'] ?? '',
//       priority: data['priority'] ?? '',
//       start: data['start'] != null ? (data['start'] as Timestamp).toDate() : null,
//       end: data['end'] != null ? (data['end'] as Timestamp).toDate() : null,
//       mineManager: data['mineManager'],
//       completed: data['completed'] ?? false,
//     );
//   }

//   // Convert a Task instance to a Firestore document
//   Map<String, dynamic> toFirestore() {
//     return {
//       'title': title,
//       'description': description,
//       'type': type,
//       'priority': priority,
//       'start': start != null ? Timestamp.fromDate(start!) : null,
//       'end': end != null ? Timestamp.fromDate(end!) : null,
//       'mineManager': mineManager,
//       'completed': completed,
//     };
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String? id;
  final String title;
  final String description;
  final String type;
  final String priority;
  final DateTime? start; // Start date
  final DateTime? end; // End date
  final String? mineManager; // Reference to a `mineManager` document ID
  final bool completed;

  const Task({
    this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.priority,
    this.start,
    this.end,
    this.mineManager,
    this.completed = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'type': type,
        'priority': priority,
        'start': start != null ? Timestamp.fromDate(start!) : null,
        'end': end != null ? Timestamp.fromDate(end!) : null,
        'mineManager': mineManager,
        'completed': completed,
      };

  static Task fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Task(
      id: snap.id,
      title: snapshot['title'] ?? '',
      description: snapshot['description'] ?? '',
      type: snapshot['type'] ?? '',
      priority: snapshot['priority'] ?? '',
      start: snapshot['start'] != null
          ? (snapshot['start'] as Timestamp).toDate()
          : null,
      end: snapshot['end'] != null
          ? (snapshot['end'] as Timestamp).toDate()
          : null,
      mineManager: snapshot['mineManager'],
      completed: snapshot['completed'] ?? false,
    );
  }

  Task copyWithStatus(bool isCompleted) {
    return Task(
      id: id,
      title: title,
      description: description,
      type: type,
      priority: priority,
      start: start,
      end: end,
      mineManager: mineManager,
      completed: isCompleted,
    );
  }
}