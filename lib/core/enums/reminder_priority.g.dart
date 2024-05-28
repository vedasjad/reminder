// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_priority.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderPriorityAdapter extends TypeAdapter<ReminderPriority> {
  @override
  final int typeId = 1;

  @override
  ReminderPriority read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ReminderPriority.low;
      case 1:
        return ReminderPriority.medium;
      case 2:
        return ReminderPriority.high;
      default:
        return ReminderPriority.low;
    }
  }

  @override
  void write(BinaryWriter writer, ReminderPriority obj) {
    switch (obj) {
      case ReminderPriority.low:
        writer.writeByte(0);
        break;
      case ReminderPriority.medium:
        writer.writeByte(1);
        break;
      case ReminderPriority.high:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderPriorityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
