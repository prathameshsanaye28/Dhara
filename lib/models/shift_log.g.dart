// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShiftLogAdapter extends TypeAdapter<ShiftLog> {
  @override
  final int typeId = 1;

  @override
  ShiftLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShiftLog(
      shiftDate: fields[0] as String,
      shiftTime: fields[1] as String,
      areaSection: fields[2] as String,
      boltsTested: fields[3] as int,
      boltsAboveRating: fields[4] as int,
      boltsBelowRating: fields[5] as int,
      remarks: fields[6] as String,
      foremanSignature: fields[7] as String,
      managerSignature: fields[8] as String,
      certificateNumber: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShiftLog obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.shiftDate)
      ..writeByte(1)
      ..write(obj.shiftTime)
      ..writeByte(2)
      ..write(obj.areaSection)
      ..writeByte(3)
      ..write(obj.boltsTested)
      ..writeByte(4)
      ..write(obj.boltsAboveRating)
      ..writeByte(5)
      ..write(obj.boltsBelowRating)
      ..writeByte(6)
      ..write(obj.remarks)
      ..writeByte(7)
      ..write(obj.foremanSignature)
      ..writeByte(8)
      ..write(obj.managerSignature)
      ..writeByte(9)
      ..write(obj.certificateNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShiftLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
