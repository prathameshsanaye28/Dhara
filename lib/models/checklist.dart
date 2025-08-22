// import 'package:cloud_firestore/cloud_firestore.dart';

// class Checklist {
//   final String? id; // Firestore document ID
//   final String title;
//   final String shiftInchargeUid;
//   final DateTime timestamp;
//   final List<Map<String, dynamic>> items;

//   Checklist({
//     this.id,
//     required this.title,
//     required this.shiftInchargeUid,
//     required this.timestamp,
//     required this.items,
//   });

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'title': title,
//         'shiftInchargeUid': shiftInchargeUid,
//         'timestamp': timestamp.toIso8601String(),
//         'items': items,
//       };

//   static Checklist fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;

//     return Checklist(
//       id: snap.id,
//       title: snapshot['title'],
//       shiftInchargeUid: snapshot['shiftInchargeUid'],
//       timestamp: DateTime.parse(snapshot['timestamp']),
//       items: List<Map<String, dynamic>>.from(snapshot['items'] ?? []),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Checklist {
  final String? id; // Firestore document ID
  final String title;
  final String shiftInchargeUid;
  final DateTime timestamp;
  final List<Map<String, dynamic>> items;

  Checklist({
    String? id,
    required this.title,
    required this.shiftInchargeUid,
    required this.timestamp,
    required this.items,
  }) : id = id ?? const Uuid().v1(); // Generate UUID if not provided

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'shiftInchargeUid': shiftInchargeUid,
        'timestamp': timestamp.toIso8601String(),
        'items': items,
      };

  static Checklist fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Checklist(
      id: snap.id,
      title: snapshot['title'],
      shiftInchargeUid: snapshot['shiftInchargeUid'],
      timestamp: DateTime.parse(snapshot['timestamp']),
      items: List<Map<String, dynamic>>.from(snapshot['items'] ?? []),
    );
  }
}