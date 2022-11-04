import 'package:dio/dio.dart';

import 'package:flutter_application_1/Entities/Wallet_Entity.dart';
import 'package:hive/hive.dart';

class WalletEntityAdapter extends TypeAdapter<WalletEntity> {
  @override
  final typeId = 1;

  @override
  WalletEntity read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletEntity(
      symbol: fields[0] as String,
      name: fields[1] as String,
      address: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WalletEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.symbol)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address);
  }
}
