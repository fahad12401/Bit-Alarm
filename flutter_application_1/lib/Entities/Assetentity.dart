import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 2)
class AssetEntity extends HiveObject {
  @HiveField(0)
  String symbol;
  @HiveField(1)
  String name;
  @HiveField(2)
  double amount;
  AssetEntity({required this.name, required this.amount, required this.symbol});
  @override
  String toString() => "$symbol - $name: $amount";
}
