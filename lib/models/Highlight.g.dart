// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Highlight.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HighlightAdapter extends TypeAdapter<Highlight> {
  @override
  final int typeId = 1;

  @override
  Highlight read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Highlight(
      text: fields[0] as String,
      isFavorite: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Highlight obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HighlightAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
