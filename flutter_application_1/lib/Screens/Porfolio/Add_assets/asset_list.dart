import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/asset_list_items.dart';
import 'package:flutter_application_1/Entities/Assetentity.dart';
import 'package:flutter_application_1/Entities/Coin_Entity.dart';
import 'package:flutter_application_1/Screens/Coin/Coin_Screen.dart';
import 'package:nav_router/nav_router.dart';

class AssetList extends StatelessWidget {
  final List<AssetEntity> assets;

  const AssetList({Key? key, required this.assets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var assetWidgets = assets
        .map((asset) => GestureDetector(
            onTap: () {
              routePush(CoinScreen(
                  coin: Coin(
                      name: asset.name,
                      symbol: asset.symbol,
                      price: asset.amount, change24th: 0, volume: 0)));
            },
            child: AssetListItems(
              asset: asset,
            )))
        .toList();
    return Wrap(
      children: assetWidgets,
      alignment: WrapAlignment.start,
      spacing: 30.0,
      runSpacing: 30.0,
      direction: Axis.horizontal,
    );
  }
}
