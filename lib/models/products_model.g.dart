// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PnameAdapter extends TypeAdapter<Pname> {
  @override
  final int typeId = 1;

  @override
  Pname read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pname(
      title: fields[0] as String?,
      pid: fields[1] as int?,
      weight: fields[2] as String?,
      cost: fields[3] as int,
      shopId: fields[4] as int?,
      qty: fields[5] as int,
      image: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Pname obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.pid)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.cost)
      ..writeByte(4)
      ..write(obj.shopId)
      ..writeByte(5)
      ..write(obj.qty)
      ..writeByte(6)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PnameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
