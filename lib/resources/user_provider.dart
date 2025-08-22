import 'package:dhara_sih/models/shiftIncharge.dart';
import 'package:dhara_sih/resources/auth_methods.dart';
import 'package:flutter/material.dart';

// class UserProvider with ChangeNotifier {
//   User? _user;
//   final AuthMethods _authMethods = AuthMethods();

//   // Getter for user
//   User? get getUser => _user;

//   Future<void> refreshUser([User? updatedUser]) async {
//     if (updatedUser != null) {
//       // If user object is provided, use it directly
//       _user = updatedUser;
//     } else {
//       // If no user object provided, fetch from AuthMethods
//       _user = await _authMethods.getUserDetails();
//     }
//     notifyListeners();
//   }

//   // Method to refresh user from AuthMethods
//   Future<void> refreshUserFromAuth() async {
//     User user = await _authMethods.getUserDetails();
//     _user = user;
//     notifyListeners();
//   }
// }

// class UserProvider with ChangeNotifier {
//   ShiftIncharge? _user;
//   final AuthMethods _authMethods = AuthMethods();

//   // Getter for user
//   ShiftIncharge? get getUser => _user;

//   Future<void> refreshUser([ShiftIncharge? updatedUser]) async {
//     if (updatedUser != null) {
//       // If user object is provided, use it directly
//       _user = updatedUser;
//     } else {
//       // If no user object provided, fetch from AuthMethods
//       _user = await _authMethods.getUserDetails();
//     }
//     notifyListeners();
//   }

//   // Method to refresh user from AuthMethods
//   Future<void> refreshUserFromAuth() async {
//     ShiftIncharge user = await _authMethods.getUserDetails();
//     _user = user;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:dhara_sih/models/shiftIncharge.dart';
import 'package:dhara_sih/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  ShiftIncharge? _user;
  final AuthMethods _authMethods = AuthMethods();

  // Getter for the current user
  ShiftIncharge? get getUser => _user;

  // Refresh user details and notify listeners
  Future<void> refreshUser([ShiftIncharge? updatedUser]) async {
    if (updatedUser != null) {
      _user = updatedUser;
    } else {
      _user = await _authMethods.getUserDetails();
    }
    notifyListeners();
  }

  // Fetch user details from Firestore and update state
  Future<void> refreshUserFromAuth() async {
    final ShiftIncharge? user = await _authMethods.getUserDetails();
    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }
}