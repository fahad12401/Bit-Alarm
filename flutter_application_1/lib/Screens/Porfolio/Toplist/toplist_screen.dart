import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/Screen_Scaffold.dart';
import 'package:flutter_application_1/Components/Sort_button.dart';
import 'package:flutter_application_1/Components/coin_list_items.dart';
import 'package:flutter_application_1/Entities/Fav_Entity.dart';
import 'package:flutter_application_1/Providers/favorite_provider.dart';
import 'package:flutter_application_1/Services/Coin_service.dart';
import 'package:provider/provider.dart';

import '../../../Entities/Coin_Entity.dart';

class TopListScreen extends StatefulWidget {
  TopListScreen();

  @override
  State<StatefulWidget> createState() => TopListState();
}

class TopListState extends State<TopListScreen> {
  TopListState();
  List<Coin> _coins = [];
  CoinService _coinService = new CoinService();
  SortProperty sortProperty = SortProperty.PRICE;
  ScrollController listcontroller = ScrollController();

  @override
  void initState() {
    super.initState();
    _getCoins;
  }

  _getCoins() async {
    var coins = await _coinService.getAllprices();
    setState(() {
      _coins = coins;
    });
  }

  void _onSort(SortProperty prop) {
    setState(() {
      sortProperty = prop;
      switch (prop) {
        case SortProperty.PRICE:
          _coins.sort((b, a) => a.price.compareTo(b.price));
          break;
        case SortProperty.GAIN:
          _coins.sort((b, a) => a.change24th.compareTo(b.change24th));
          break;
        case SortProperty.LOSE:
          _coins.sort((a, b) => a.change24th.compareTo(b.change24th));
          break;
      }
    });
  }

  void toggleFavorite(Coin coin) {
    final store = Provider.of<FavoriteModel>(context);
    var favorite = FavoriteEntity(symbol: coin.symbol, name: coin.name);
    store.addFavorite(favorite);
  }

  @override
  Widget build(BuildContext context) {
    var coinWidgets = _coins
        .map((coin) => Padding(
              padding: EdgeInsets.fromLTRB(48, 8, 48, 8),
              child: CoinListItems(
                coin: coin,
              ),
            ))
        .toList();
    return ScreenScaffold(
      title: "TopList",
      activeNavBar: "TopList",
      drawer: Drawer(),
      fab: FloatingActionButton(onPressed: () {}),
      childern: [
        SliverToBoxAdapter(
          child:  SortButtonGroup(onSort: _onSort, active: sortProperty),
        ),
        SliverList(delegate: SliverChildListDelegate(coinWidgets))
      ],
    );
    
  }
}
