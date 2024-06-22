// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premath_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreMathProgressModelAdapter extends TypeAdapter<PreMathProgressModel> {
  @override
  final int typeId = 0;

  @override
  PreMathProgressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PreMathProgressModel(
      progress: fields[0] as double,
      id: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PreMathProgressModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.progress)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreMathProgressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
