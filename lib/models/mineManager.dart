// import 'package:cloud_firestore/cloud_firestore.dart';

// class MineManager {
//   String? id;
//   String? name;
//   String? email;
//   String? password;
//   String? phone;
//   String role;
//   List<String>? shiftInchargeIds; // List of IDs referencing shiftIncharge documents
//   String? mineId; // ID referencing a mine document
//   List<String>? taskIds; // List of IDs referencing task documents
//   List<String>? jobIds; // List of IDs referencing job documents
//   List<String>? notifIds; // List of IDs referencing notif documents
//   List<String>? teamIds; // List of IDs referencing team documents

//   MineManager({
//     this.id,
//     this.name,
//     this.email,
//     this.password,
//     this.phone,
//     this.role = "Mine Manager",
//     this.shiftInchargeIds,
//     this.mineId,
//     this.taskIds,
//     this.jobIds,
//     this.notifIds,
//     this.teamIds,
//   });

//   // Method to convert Firestore document snapshot to MineManager object
//   factory MineManager.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

//     return MineManager(
//       id: doc.id,
//       name: data['name'],
//       email: data['email'],
//       password: data['password'],
//       phone: data['phone'],
//       role: data['role'] ?? "Mine Manager",
//       shiftInchargeIds: List<String>.from(data['shiftIncharge'] ?? []),
//       mineId: data['mine'],
//       taskIds: List<String>.from(data['task'] ?? []),
//       jobIds: List<String>.from(data['job'] ?? []),
//       notifIds: List<String>.from(data['notif'] ?? []),
//       teamIds: List<String>.from(data['team'] ?? []),
//     );
//   }

//   // Method to convert MineManager object to Firestore map
//   Map<String, dynamic> toFirestore() {
//     return {
//       'name': name,
//       'email': email,
//       'password': password,
//       'phone': phone,
//       'role': role,
//       'shiftIncharge': shiftInchargeIds,
//       'mine': mineId,
//       'task': taskIds,
//       'job': jobIds,
//       'notif': notifIds,
//       'team': teamIds,
//     };
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';

class MineManager {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String role;
  final List<String> shiftInchargeIds; // List of IDs referencing shiftIncharge documents
  final String? mineId; // ID referencing a mine document
  final List<String> taskIds; // List of IDs referencing task documents
  final List<String> jobIds; // List of IDs referencing job documents
  final List<String> notifIds; // List of IDs referencing notif documents
  final List<String> teamIds; // List of IDs referencing team documents

  const MineManager({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.role = "Mine Manager",
    this.shiftInchargeIds = const [],
    this.mineId,
    this.taskIds = const [],
    this.jobIds = const [],
    this.notifIds = const [],
    this.teamIds = const [],
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
        'shiftIncharge': shiftInchargeIds,
        'mine': mineId,
        'task': taskIds,
        'job': jobIds,
        'notif': notifIds,
        'team': teamIds,
      };

  static MineManager fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return MineManager(
      id: snap.id,
      name: snapshot['name'],
      email: snapshot['email'],
      phone: snapshot['phone'],
      role: snapshot['role'] ?? "Mine Manager",
      shiftInchargeIds: List<String>.from(snapshot['shiftIncharge'] ?? []),
      mineId: snapshot['mine'],
      taskIds: List<String>.from(snapshot['task'] ?? []),
      jobIds: List<String>.from(snapshot['job'] ?? []),
      notifIds: List<String>.from(snapshot['notif'] ?? []),
      teamIds: List<String>.from(snapshot['team'] ?? []),
    );
  }

  MineManager copyWithLocation(String? newMineId) {
    return MineManager(
      id: id,
      name: name,
      email: email,
      phone: phone,
      role: role,
      shiftInchargeIds: shiftInchargeIds,
      mineId: newMineId,
      taskIds: taskIds,
      jobIds: jobIds,
      notifIds: notifIds,
      teamIds: teamIds,
    );
  }
}