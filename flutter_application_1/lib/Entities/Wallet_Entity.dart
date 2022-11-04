import 'package:hive/hive.dart';



@HiveType(typeId: 1)
class WalletEntity extends HiveObject {
  @HiveField(0)
  String symbol;

  @HiveField(1)
  String name;

  @HiveField(2)
  String address;

  WalletEntity({required this.symbol, required this.name, required this.address});

  @override
  String toString() => "$symbol: $address";
}
