import 'package:rive/rive.dart';

class Menu {
  final String title;
  final RiveModel rive;
  String? screenPath;

  Menu({required this.title, required this.rive});
}

class RiveModel {
  final String src;
  final String artboard;
  final String stateMachineName;
  SMIBool? status;

  RiveModel({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
  });
}
