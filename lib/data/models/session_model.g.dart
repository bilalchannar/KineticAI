// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionModelAdapter extends TypeAdapter<SessionModel> {
  @override
  final int typeId = 0;

  @override
  SessionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionModel(
      id: fields[0] as String,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as DateTime,
      activityType: fields[3] as ActivityType,
      averageSpeed: fields[4] as double,
      distance: fields[5] as double,
      steps: fields[6] as int,
      calories: fields[7] as double,
      averageSymmetry: fields[8] as double,
      elevationGain: fields[9] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SessionModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.activityType)
      ..writeByte(4)
      ..write(obj.averageSpeed)
      ..writeByte(5)
      ..write(obj.distance)
      ..writeByte(6)
      ..write(obj.steps)
      ..writeByte(7)
      ..write(obj.calories)
      ..writeByte(8)
      ..write(obj.averageSymmetry)
      ..writeByte(9)
      ..write(obj.elevationGain);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
