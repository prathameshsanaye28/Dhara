// import 'package:cloud_firestore/cloud_firestore.dart';

// class Team {
//   String? id;
//   String name;
//   String description;
//   List<String> shiftIncharge; // List of references to `shiftIncharge` document IDs
//   String? mineManager; // Reference to a `mineManager` document ID
//   String? mine; // Reference to a `mine` document ID
//   List<String> job; // List of references to `job` document IDs

//   Team({
//     this.id,
//     required this.name,
//     required this.description,
//     this.shiftIncharge = const [],
//     this.mineManager,
//     this.mine,
//     this.job = const [],
//   });

//   // Convert a Firestore document to a Team instance
//   factory Team.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

//     return Team(
//       id: doc.id,
//       name: data['name'] ?? '',
//       description: data['description'] ?? '',
//       shiftIncharge: List<String>.from(data['shiftIncharge'] ?? []),
//       mineManager: data['mineManager'],
//       mine: data['mine'],
//       job: List<String>.from(data['job'] ?? []),
//     );
//   }

//   // Convert a Team instance to a Firestore document
//   Map<String, dynamic> toFirestore() {
//     return {
//       'name': name,
//       'description': description,
//       'shiftIncharge': shiftIncharge,
//       'mineManager': mineManager,
//       'mine': mine,
//       'job': job,
//     };
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class Team {
  final String? id;
  final String name;
  final String description;
  final List<String> shiftIncharge; // List of references to `shiftIncharge` document IDs
  final String? mineManager; // Reference to a `mineManager` document ID
  final String? mine; // Reference to a `mine` document ID
  final List<String> job; // List of references to `job` document IDs

  const Team({
    this.id,
    required this.name,
    required this.description,
    this.shiftIncharge = const [],
    this.mineManager,
    this.mine,
    this.job = const [],
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'shiftIncharge': shiftIncharge,
        'mineManager': mineManager,
        'mine': mine,
        'job': job,
      };

  static Team fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Team(
      id: snap.id,
      name: snapshot['name'] ?? '',
      description: snapshot['description'] ?? '',
      shiftIncharge: List<String>.from(snapshot['shiftIncharge'] ?? []),
      mineManager: snapshot['mineManager'],
      mine: snapshot['mine'],
      job: List<String>.from(snapshot['job'] ?? []),
    );
  }

  Team copyWith({
    String? newName,
    String? newDescription,
    List<String>? newShiftIncharge,
    String? newMineManager,
    String? newMine,
    List<String>? newJob,
  }) {
    return Team(
      id: id,
      name: newName ?? name,
      description: newDescription ?? description,
      shiftIncharge: newShiftIncharge ?? shiftIncharge,
      mineManager: newMineManager ?? mineManager,
      mine: newMine ?? mine,
      job: newJob ?? job,
    );
  }
}