import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Components/coin_list_items.dart';
import 'package:flutter_application_1/Entities/Coin_Entity.dart';
import 'package:flutter_application_1/Entities/Fav_Entity.dart';
import 'package:hive/hive.dart';

class FavoriteModel extends ChangeNotifier {
  var Box = Hive.box<FavoriteEntity>('favorites');
  List<FavoriteEntity> list = [];
  FavoriteModel() {
    list = Box.values.toList();
    notifyListeners();
  }
  addFavorite(FavoriteEntity favorite) {
    list.add(favorite);
    Box.add(favorite);
    notifyListeners();
  }

  removeFavorite(FavoriteEntity favorite) {
    Coin coin = Coin(
        name: favorite.name,
        symbol: favorite.symbol,
        change24th: 0,
        volume: 0,
        price: 0);
    if (isFavorite(coin)) {
      removeFavorite(favorite);
    } else {
      addFavorite(favorite);
    }
  }

  bool isFavorite(Coin coin) {
    var found = list.firstWhere((favorite) => favorite.symbol == coin.symbol,
        orElse: () => null!);
    
    return found != null;
  }

  toggleFavorite(FavoriteEntity favorite) {
    Coin coin = Coin(name: favorite.name, symbol: favorite.symbol, change24th: 0, volume: 0, price: 0);
    if (isFavorite(coin)) {
      removeFavorite(favorite);
    } else {
      addFavorite(favorite);
    }
  }

 
}
