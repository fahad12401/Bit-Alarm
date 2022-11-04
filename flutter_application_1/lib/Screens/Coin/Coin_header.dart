import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_application_1/Components/Screen_headline.dart';
import 'package:flutter_application_1/Entities/Coin_Entity.dart';
import 'package:flutter_application_1/Entities/Fav_Entity.dart';
import 'package:flutter_application_1/Screens/Coin/Coingraph.dart';
import 'package:flutter_application_1/Screens/Coin/Coingraph_label.dart';
import 'package:provider/provider.dart';

import '../../Providers/favorite_provider.dart';

class CoinHeader extends StatelessWidget {
  final Coin coin;
  final List<double> priceData;
  final bool isFavorite;
  CoinHeader(
      {Key? key,
      required this.coin,
      this.priceData = const [],
      required this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: CoinHeaderDelegate(
          coin: coin,
          isFavorite: isFavorite,
          minExtent: 100,
          maxExtent: 220,
          priceData: priceData),
    );
  }
}

class CoinHeaderDelegate implements SliverPersistentHeaderDelegate {
  final double minExtent;
  final double maxExtent;
  final Coin coin;
  final List<double> priceData;
  final bool isFavorite;

  CoinHeaderDelegate(
      {required this.coin,
      required this.isFavorite,
      required this.maxExtent,
      required this.minExtent,
      this.priceData = const []});

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;
  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;

  _getOpacityforOffset(double shrinkOffset) {
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  }

  _toggleFavorite(BuildContext context) {
    var store = Provider.of<FavoriteModel>(context, listen: false);
    var favorite = FavoriteEntity(symbol: coin.symbol, name: coin.name);
    store.toggleFavorite(favorite);
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapContent) {
    double opacity = _getOpacityforOffset(shrinkOffset);
    return Stack(
      fit: StackFit.expand,
      children: [
        ScreenHeadline(text: coin.name, opacity: opacity),
        Padding(
          padding: EdgeInsets.only(
            top: 80,
            bottom: 40,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CoinGraph(data: priceData),
              CoinGrapgLabels(priceData),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    color: Colors.white,
                    onPressed: Navigator.of(context).pop,
                    icon: Icon(Icons.arrow_back)),
                IconButton(
                    onPressed: () {
                      _toggleFavorite(context);
                    },
                    icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border))
              ],
            ))
      ],
    );
  }

  @override
  // TODO: implement showOnScreenConfiguration
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      throw UnimplementedError();

  @override
  // TODO: implement vsync
  TickerProvider? get vsync => throw UnimplementedError();
}
