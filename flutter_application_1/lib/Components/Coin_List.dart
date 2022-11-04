import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/coin_list_items.dart';

import '../Entities/Coin_Entity.dart';

class CoinList extends StatelessWidget {
  final List<Coin> coins;
  final ScrollController controller;
  const CoinList({Key? key, required this.coins, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var coinList = coins
        .map((coin) => CoinListItems(
              coin: coin,
            ))
        .toList();
    return ListView(
        controller: controller, children: coinList, padding: EdgeInsets.all(0));
  }
}
