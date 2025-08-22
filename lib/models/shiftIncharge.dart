// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class ShiftIncharge {
// //   String? id;
// //   String name;
// //   String email;
// //   String password;
// //   String phone;
// //   String role;
// //   String department;
// //   String? location; // Can be null
// //   String? mine; // Reference to a `mine` document ID
// //   String? mineManager; // Reference to a `mineManager` document ID
// //   List<String> task; // List of references to `task` document IDs
// //   List<String> job; // List of references to `job` document IDs
// //   List<String> notif; // List of references to `notif` document IDs
// //   List<String> team; // List of references to `team` document IDs

// //   ShiftIncharge({
// //     this.id,
// //     required this.name,
// //     required this.email,
// //     required this.password,
// //     required this.phone,
// //     this.role = "Shift Incharge",
// //     this.department = "Morning Shift",
// //     this.location,
// //     this.mine,
// //     this.mineManager,
// //     this.task = const [],
// //     this.job = const [],
// //     this.notif = const [],
// //     this.team = const [],
// //   });

// //   // Convert a Firestore document to a ShiftIncharge instance
// //   factory ShiftIncharge.fromFirestore(DocumentSnapshot doc) {
// //     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

// //     return ShiftIncharge(
// //       id: doc.id,
// //       name: data['name'] ?? '',
// //       email: data['email'] ?? '',
// //       password: data['password'] ?? '',
// //       phone: data['phone'] ?? '',
// //       role: data['role'] ?? 'Shift Incharge',
// //       department: data['department'] ?? 'Morning Shift',
// //       location: data['location'],
// //       mine: data['mine'],
// //       mineManager: data['mineManager'],
// //       task: List<String>.from(data['task'] ?? []),
// //       job: List<String>.from(data['job'] ?? []),
// //       notif: List<String>.from(data['notif'] ?? []),
// //       team: List<String>.from(data['team'] ?? []),
// //     );
// //   }

// //   // Convert a ShiftIncharge instance to a Firestore document
// //   Map<String, dynamic> toFirestore() {
// //     return {
// //       'name': name,
// //       'email': email,
// //       'password': password,
// //       'phone': phone,
// //       'role': role,
// //       'department': department,
// //       'location': location,
// //       'mine': mine,
// //       'mineManager': mineManager,
// //       'task': task,
// //       'job': job,
// //       'notif': notif,
// //       'team': team,
// //     };
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';

// class ShiftIncharge {
//   final String? id;
//   final String name;
//   final String email;
//   final String phone;
//   final String department;
//   final String? location;
//   final String? mine;
//   final String? mineManager;
//   final List<String> task;
//   final List<String> job;
//   final List<String> notif;
//   final List<String> team;

//   const ShiftIncharge({
//     this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.department,
//     this.location,
//     this.mine,
//     this.mineManager,
//     this.task = const [],
//     this.job = const [],
//     this.notif = const [],
//     this.team = const [],
//   });

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'name': name,
//         'email': email,
//         'phone': phone,
//         'department': department,
//         'location': location,
//         'mine': mine,
//         'mineManager': mineManager,
//         'task': task,
//         'job': job,
//         'notif': notif,
//         'team': team,
//       };

//   static ShiftIncharge fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;

//     return ShiftIncharge(
//       id: snap.id,
//       name: snapshot['name'],
//       email: snapshot['email'],
//       phone: snapshot['phone'],
//       department: snapshot['department'],
//       location: snapshot['location'],
//       mine: snapshot['mine'],
//       mineManager: snapshot['mineManager'],
//       task: List<String>.from(snapshot['task'] ?? []),
//       job: List<String>.from(snapshot['job'] ?? []),
//       notif: List<String>.from(snapshot['notif'] ?? []),
//       team: List<String>.from(snapshot['team'] ?? []),
//     );
//   }

//   ShiftIncharge copyWithLocation(String? newLocation) {
//     return ShiftIncharge(
//       id: id,
//       name: name,
//       email: email,
//       phone: phone,
//       department: department,
//       location: newLocation,
//       mine: mine,
//       mineManager: mineManager,
//       task: task,
//       job: job,
//       notif: notif,
//       team: team,
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class ShiftIncharge {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String department;
  final String? location;
  final String? mine;
  final String? mineManager;
  final List<String> task;
  final List<String> job;
  final List<String> notif;
  final List<String> team;
  final List<String> checklists; // List of checklist IDs

  const ShiftIncharge({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    this.location,
    this.mine,
    this.mineManager,
    this.task = const [],
    this.job = const [],
    this.notif = const [],
    this.team = const [],
    this.checklists = const [],
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'department': department,
        'location': location,
        'mine': mine,
        'mineManager': mineManager,
        'task': task,
        'job': job,
        'notif': notif,
        'team': team,
        'checklists': checklists,
      };

  static ShiftIncharge fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ShiftIncharge(
      id: snap.id,
      name: snapshot['name'],
      email: snapshot['email'],
      phone: snapshot['phone'],
      department: snapshot['department'],
      location: snapshot['location'],
      mine: snapshot['mine'],
      mineManager: snapshot['mineManager'],
      task: List<String>.from(snapshot['task'] ?? []),
      job: List<String>.from(snapshot['job'] ?? []),
      notif: List<String>.from(snapshot['notif'] ?? []),
      team: List<String>.from(snapshot['team'] ?? []),
      checklists: List<String>.from(snapshot['checklists'] ?? []),
    );
  }
}
