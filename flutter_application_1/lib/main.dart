import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Entities/Assetentity.dart';
import 'package:flutter_application_1/Entities/Fav_Entity.dart';
import 'package:flutter_application_1/Entities/Wallet_Entity.dart';
import 'package:flutter_application_1/Providers/Wallets_provider.dart';
import 'package:flutter_application_1/Providers/favorite_provider.dart';
import 'package:flutter_application_1/Screens/Favourites/Favourite_Screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nav_router/nav_router.dart';
import 'package:provider/provider.dart';

import 'Entities/Assetentity.g.dart';
import 'Entities/Fav.g.dart';
import 'Entities/Wallet.g.Entity.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteEntityAdapter());
  Hive.registerAdapter(WalletEntityAdapter());
  Hive.registerAdapter(AssetEntityAdapter());
  await Hive.openBox<FavoriteEntity>('favorites');
  await Hive.openBox<WalletEntity>('wallets');
  await Hive.openBox<AssetEntity>('assets');
  runApp(Alarm());
}

class Alarm extends StatefulWidget {
  const Alarm({Key? key}) : super(key: key);

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<FavoriteModel>(create: (_) => FavoriteModel()),
      ChangeNotifierProvider<WalletsModel>(create: (_) => WalletsModel()),

    ],
    child:  MaterialApp(
      title: 'Alarm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black38,
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: FavoriteScreen(),
      navigatorKey: navGK,
    ),);
  }
}
