import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/Screen_Scaffold.dart';
import 'package:flutter_application_1/Components/coin_list_items.dart';
import 'package:flutter_application_1/Providers/favorite_provider.dart';
import 'package:flutter_application_1/Services/Coin_service.dart';
import 'package:provider/provider.dart';

import '../../Entities/Coin_Entity.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  CoinService coinService = CoinService();
  List<Coin> _favorites = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final store = Provider.of<FavoriteModel>(context).list;
    var favoriteSymbols = store.map((coin) => coin.symbol).toList();
    var favs = await coinService.getPriceForSymbols(favoriteSymbols);
    setState(() {
      _favorites = favs;
    });
  }

  @override
  Widget build(BuildContext context) {
    var CoinWidgets = _favorites
        .map((coin) => Padding(
            padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
            child: CoinListItems(coin: coin)))
        .toList();
    return ScreenScaffold(
      title: "Favourites",
      activeNavBar: "Favourites",
      drawer: Drawer(),
      fab: FloatingActionButton(onPressed: () {}),
      childern: [SliverList(delegate: SliverChildListDelegate(CoinWidgets))],
    );
  }
}
