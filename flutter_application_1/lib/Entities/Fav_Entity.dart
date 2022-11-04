import 'package:hive/hive.dart';



@HiveType(typeId: 0)
class FavoriteEntity extends HiveObject {
  @HiveField(0)
  late String symbol;

  @HiveField(1)
  late String name;

  FavoriteEntity({required this.symbol, required this.name});
  FavoriteEntity.FROMJSON(dynamic json) {
    symbol = json['symbol'];
    name = json['name'];
  }

  @override
  String toString() => "$symbol - $name";
}
