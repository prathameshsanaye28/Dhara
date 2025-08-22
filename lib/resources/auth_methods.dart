
// import 'dart:typed_data';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';


// class AuthMethods{
//  final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//     Future<model.User> getUserDetails() async {
//     User currentUser = _auth.currentUser!;
//     DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();
//     return model.User.fromSnap(snap);
//   }

//   Future<String> signUpUser({
//     required String email,
//     required String password,
//     required String username,
//     required String fullname,
//     required String contactnumber,
//     required Uint8List file,
//     required int age,
//     required double weight,
//     required double height,
//     required String wakeUpTime,
//     required String bedTime,
//     required String workStartTime,
//     required String workEndTime,
//   }) async {
//     String res = "Some error occurred";
//     try {
//       if (email.isNotEmpty && 
//           password.isNotEmpty && 
//           username.isNotEmpty && 
//           fullname.isNotEmpty && 
//           contactnumber.isNotEmpty && 
//           file != null) {
//         UserCredential cred = await _auth.createUserWithEmailAndPassword(
//           email: email, 
//           password: password
//         );
        
//         String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

//         model.User user = model.User(
//           uid: cred.user!.uid,
//           username: username,
//           email: email,
//           fullname: fullname,
//           photoUrl: photoUrl,
//           contactnumber: contactnumber,
//           age: age,
//           weight: weight,
//           height: height,
//           wakeUpTime: wakeUpTime,
//           bedTime: bedTime,
//           workStartTime: workStartTime,
//           workEndTime: workEndTime,
//         );

//         await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
//         res = 'success';
//       } 
//     } on FirebaseAuthException catch(err) {
//       if (err.code == 'invalid-email') {
//         res = 'The email is invalid';
//       }
//       if (err.code == 'weak-password') {
//         res = 'Password is weak';
//       }
//     } catch(err) {
//       res = err.toString();
//     }
//     return res;
//   }
//   //logging in
//   Future<String> loginUser({
//     required String email,
//     required String password
//   })async{
//     String res = 'Some error occured';
//     try{
//       if(email.isNotEmpty || password.isNotEmpty)
//       {
//         await _auth.signInWithEmailAndPassword(email: email, password: password);
//         res = 'success';
//       }
//       else{
//         res = 'Please enter all details';
//       }
//     }
//     catch(err){
//       res = err.toString();
//     }
//     return res;
//   }
  
//   Future<void> signOut() async {
//   try {
//     await FirebaseAuth.instance.signOut();
//     print('User signed out successfully');
//   } catch (e) {
//     print('Error signing out: $e');
//   }
// }


// }


import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhara_sih/models/shiftIncharge.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch ShiftIncharge details
  Future<ShiftIncharge?> getUserDetails() async {
  final User? currentUser = _auth.currentUser;

  if (currentUser == null) {
    // No user is signed in
    return null;
  }

  try {
    final DocumentSnapshot snap = await _firestore
        .collection('shiftIncharges')
        .doc(currentUser.uid)
        .get();

    if (snap.exists) {
      return ShiftIncharge.fromSnap(snap);
    } else {
      // Document doesn't exist, handle appropriately
      print('No document found for user: ${currentUser.uid}');
      return null;
    }
  } catch (e) {
    print('Error fetching user details: $e');
    return null;
  }
}

  // Sign up a new ShiftIncharge user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String department,
    String? location,
    String? mine,
    String? mineManager,
    List<String> task = const [],
    List<String> job = const [],
    List<String> notif = const [],
    List<String> team = const [],
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          phone.isNotEmpty &&
          department.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        ShiftIncharge shiftIncharge = ShiftIncharge(
          id: cred.user!.uid,
          name: name,
          email: email,
          phone: phone,
          department: department,
          location: location,
          mine: mine,
          mineManager: mineManager,
          task: task,
          job: job,
          notif: notif,
          team: team,
        );

        await _firestore.collection('shiftIncharges').doc(cred.user!.uid).set(shiftIncharge.toJson());
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is invalid';
      } else if (err.code == 'weak-password') {
        res = 'Password is too weak';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Logging in an existing ShiftIncharge user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all details';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Sign out the current user
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('User signed out successfully');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}