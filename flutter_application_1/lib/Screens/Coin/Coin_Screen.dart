import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/Order_book.dart';
import 'package:flutter_application_1/Screens/Coin/Coin_header.dart';
import 'package:flutter_application_1/Services/Coin_service.dart';
import 'package:provider/provider.dart';

import '../../Entities/Coin_Entity.dart';
import '../../Providers/favorite_provider.dart';

class CoinScreen extends StatefulWidget {
  final Coin coin;

  const CoinScreen({Key? key, required this.coin}) : super(key: key);

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  CoinService coinService = CoinService();
  bool _isFavorite = false;
  List<double> _historicalPriceData = [];
  @override
  void initState() {
    _getCoinData();
    super.initState();
  }

  _getCoinData() async {
    List<double> data =
        await coinService.getHistoricalCoinData(widget.coin.symbol);
    setState(() {
      _historicalPriceData = data;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final store = Provider.of<FavoriteModel>(context);
    setState(() {
      _isFavorite = store.isFavorite(widget.coin);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width + 100,
            height: MediaQuery.of(context).size.height,
            image: AssetImage('assets/images/dark-page-background.png'),
          ),
          CustomScrollView(
            slivers: [
              CoinHeader(coin: widget.coin, isFavorite: _isFavorite,
              priceData: _historicalPriceData,),
              SliverList(delegate: SliverChildListDelegate([Orderbook(coin: widget.coin)]))
            ],
            
          )
        ],
      ),




    );
  }
}
