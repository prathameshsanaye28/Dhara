// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dhara_sih/models/checklist.dart';

// class ChecklistServices {
//   Future<void> createChecklist(Checklist checklist, String shiftInchargeId) async {
//   final checklistRef = FirebaseFirestore.instance.collection('checklists').doc();
//   final shiftInchargeRef = FirebaseFirestore.instance.collection('shiftIncharges').doc(shiftInchargeId);

//   await FirebaseFirestore.instance.runTransaction((transaction) async {
//     transaction.set(checklistRef, checklist.toJson());
//     transaction.update(shiftInchargeRef, {
//       'checklists': FieldValue.arrayUnion([checklistRef.id])
//     });
//   });
// }

//   Future<List<Checklist>> fetchChecklists(String shiftInchargeId) async {
//   final querySnapshot = await FirebaseFirestore.instance
//       .collection('checklists')
//       .where('shiftInchargeUid', isEqualTo: shiftInchargeId)
//       .get();

//   return querySnapshot.docs.map((doc) => Checklist.fromSnap(doc)).toList();
// }

// Future<void> updateChecklistItemStatus(String checklistId, List<Map<String, dynamic>> updatedItems) async {
//   final checklistRef = FirebaseFirestore.instance.collection('checklists').doc(checklistId);
//   await checklistRef.update({'items': updatedItems});
// }

// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhara_sih/models/checklist.dart';
import 'package:uuid/uuid.dart';

class ChecklistServices {
  // Future<String> createChecklist(Checklist checklist, String shiftInchargeId) async {
  //   final uuid = const Uuid();
  //   final checklistId = uuid.v1(); // Generate a unique ID based on timestamp
  //   final checklistRef = FirebaseFirestore.instance
  //       .collection('checklists')
  //       .doc(checklistId);
  //   final shiftInchargeRef = FirebaseFirestore.instance
  //       .collection('shiftIncharges')
  //       .doc(shiftInchargeId);

  //   // Create a copy of the checklist with the new unique ID
  //   final newChecklist = Checklist(
  //     id: checklistId,
  //     title: checklist.title,
  //     shiftInchargeUid: shiftInchargeId,
  //     timestamp: DateTime.now(), // Use current time
  //     items: checklist.items,
  //   );

  //   await FirebaseFirestore.instance.runTransaction((transaction) async {
  //     // Set the new checklist document
  //     transaction.set(checklistRef, newChecklist.toJson());

  //     // Update the shift incharge's checklist references
  //     transaction.update(shiftInchargeRef, {
  //       'checklists': FieldValue.arrayUnion([checklistId])
  //     });
  //   });

  //   return checklistId; // Return the new checklist ID
  // }

  Future<String> createChecklist(Checklist checklist, String shiftInchargeId) async {
  final uuid = const Uuid();
  final checklistId = uuid.v1(); // Generate a unique ID based on timestamp
  
  // Reference to the specific shift incharge document
  final shiftInchargeRef = FirebaseFirestore.instance
      .collection('shiftIncharges')
      .doc(shiftInchargeId);
  
  // Reference to the subcollection of checklists for this shift incharge
  final checklistRef = shiftInchargeRef
      .collection('checklists')
      .doc(checklistId);

  // Create a copy of the checklist with the new unique ID
  final newChecklist = Checklist(
    id: checklistId,
    title: checklist.title,
    shiftInchargeUid: shiftInchargeId,
    timestamp: DateTime.now(), // Use current time
    items: checklist.items,
  );

  // Set the new checklist in the subcollection
  await checklistRef.set(newChecklist.toJson());

  return checklistId; // Return the new checklist ID
}

  // Future<List<Checklist>> fetchChecklists(String shiftInchargeId) async {
  //   final querySnapshot = await FirebaseFirestore.instance
  //       .collection('checklists')
  //       .where('shiftInchargeUid', isEqualTo: shiftInchargeId)
  //       .orderBy('timestamp', descending: true) // Optional: order by most recent
  //       .get();

  //   return querySnapshot.docs.map((doc) => Checklist.fromSnap(doc)).toList();
  // }

  Future<List<Checklist>> fetchChecklists(String shiftInchargeId) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('shiftIncharges')
      .doc(shiftInchargeId)
      .collection('checklists')
      .orderBy('timestamp', descending: true)
      .get();

  return querySnapshot.docs.map((doc) => Checklist.fromSnap(doc)).toList();
}

  // Future<void> updateChecklistItemStatus(String checklistId, List<Map<String, dynamic>> updatedItems) async {
  //   final checklistRef = FirebaseFirestore.instance.collection('checklists').doc(checklistId);
  //   await checklistRef.update({
  //     'items': updatedItems,
  //     'updatedAt': FieldValue.serverTimestamp(), // Optional: track update time
  //   });
  // }
  Future<void> updateChecklistItemStatus(String shiftInchargeId, String checklistId, List<Map<String, dynamic>> updatedItems) async {
  final checklistRef = FirebaseFirestore.instance
      .collection('shiftIncharges')
      .doc(shiftInchargeId)
      .collection('checklists')
      .doc(checklistId);

  await checklistRef.update({
    'items': updatedItems,
    'updatedAt': FieldValue.serverTimestamp(), // Optional: track update time
  });
}
}