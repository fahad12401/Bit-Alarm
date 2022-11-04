import 'dart:html';

import 'package:flutter_application_1/Entities/Assetentity.dart';
import 'package:hive/hive.dart';

class AssetEntityAdapter extends TypeAdapter<AssetEntity> {
  @override
  final typeId = 2;
  @override
  AssetEntity read(BinaryReader reader) {
    var numOffields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOffields; i++) reader.readByte(): reader.read()
    };
    return AssetEntity(
        name: fields[0] as String,
        amount: fields[1] as double,
        symbol: fields[2] as String);
  }

  @override
  void write(BinaryWriter writer, AssetEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.symbol)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.name);
  }
}
