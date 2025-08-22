import 'package:hive/hive.dart';

part 'shift_log.g.dart';

@HiveType(typeId: 1)
class ShiftLog {
  @HiveField(0)
  late String shiftDate;

  @HiveField(1)
  late String shiftTime;

  @HiveField(2)
  late String areaSection;

  @HiveField(3)
  late int boltsTested;

  @HiveField(4)
  late int boltsAboveRating;

  @HiveField(5)
  late int boltsBelowRating;

  @HiveField(6)
  late String remarks;

  @HiveField(7)
  late String foremanSignature;

  @HiveField(8)
  late String managerSignature;

  @HiveField(9)
  late String certificateNumber;

  ShiftLog({
    required this.shiftDate,
    required this.shiftTime,
    required this.areaSection,
    required this.boltsTested,
    required this.boltsAboveRating,
    required this.boltsBelowRating,
    required this.remarks,
    required this.foremanSignature,
    required this.managerSignature,
    required this.certificateNumber,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'shiftDate': shiftDate,
      'shiftTime': shiftTime,
      'areaSection': areaSection,
      'boltsTested': boltsTested,
      'boltsAboveRating': boltsAboveRating,
      'boltsBelowRating': boltsBelowRating,
      'remarks': remarks,
      'foremanSignature': foremanSignature,
      'managerSignature': managerSignature,
      'certificateNumber': certificateNumber,
    };
  }

  // fromJson method
  factory ShiftLog.fromJson(Map<String, dynamic> json) {
    return ShiftLog(
      shiftDate: json['shiftDate'],
      shiftTime: json['shiftTime'],
      areaSection: json['areaSection'],
      boltsTested: json['boltsTested'],
      boltsAboveRating: json['boltsAboveRating'],
      boltsBelowRating: json['boltsBelowRating'],
      remarks: json['remarks'],
      foremanSignature: json['foremanSignature'],
      managerSignature: json['managerSignature'],
      certificateNumber: json['certificateNumber'],
    );
  }
}
