import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/Donut_chart.dart';
import 'package:flutter_application_1/Components/Screen_Scaffold.dart';
import 'package:flutter_application_1/Components/add_wallet_button.dart';
import 'package:flutter_application_1/Entities/Assetentity.dart';
import 'package:flutter_application_1/Providers/Wallets_provider.dart';
import 'package:flutter_application_1/Screens/Porfolio/Add_assets/asset_list.dart';
import 'package:flutter_application_1/Services/Coin_service.dart';
import 'package:flutter_application_1/Services/Wallet_service.dart';
import 'package:provider/provider.dart';

class PorfolioScreen extends StatefulWidget {
  PorfolioScreen();

  @override
  State<PorfolioScreen> createState() => _PorfolioScreenState();
}

class _PorfolioScreenState extends State<PorfolioScreen> {
  List<AssetEntity> assets = [];
  Map<String, double> prices = Map();
  Map<String, double> assetData = Map();
  Map<String, Color> colors = Map();
  @override
  initState() {
    super.initState();
    _setPrices();
  }

  _setPrices() async {
    var service = CoinService();
    var coins = await service.getAllprices();
    coins.forEach((coin) {
      prices[coin.symbol] = coin.price;
    });
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    assets = Provider.of<WalletsModel>(context)
        .assets
        .map((asset) => asset)
        .toList();
    assetData.clear();
    assets.forEach((asset) {
      assetData[asset.symbol] = asset.amount;
      setState(() {});
    });
    setState(() {});
    _getwalletData();
    _setColors();
    super.didChangeDependencies();
  }

  @override
  dispose() {
    assets = [];
    assetData.clear();
    super.dispose();
  }

  _setColors() async {
    assets.forEach((asset) async {
      var nameSum = asset.name
              .split('')
              .map((char) => char.codeUnitAt(0))
              .reduce((value, element) => value + element) *
          100000;
      nameSum.toRadixString(16);
      Color color = Color(nameSum).withOpacity(1);
      colors[asset.symbol] = color;
    });
    setState(() {});
  }

  _getwalletData() async {
    var wallets = Provider.of<WalletsModel>(context, listen: false).wallets;
    var walletService = WalletService();
    await for (var asset in walletService.getWalletValues(wallets)) {
      int index = assets.indexWhere((needle) => needle.symbol == asset.symbol);
      if (index != -1) {
        assets[index].amount += asset.amount;
      } else {
        assets.add(asset);
      }
      assetData.update(asset.symbol, (value) => value + asset.amount,
          ifAbsent: () => asset.amount);
      _setColors();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: "Porfolio",
      activeNavBar: "Porfolio",
      childern: [
        SliverList(
            delegate: SliverChildListDelegate([
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DonutChart(data: assetData, prices: prices, colors: colors),
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: AddWalletButton(),
              ),
              AssetList(assets: assets)
            ],
          )
        ]))
      ],
      drawer: Drawer(),
      fab: FloatingActionButton(onPressed: () {})
    );
  }
}
