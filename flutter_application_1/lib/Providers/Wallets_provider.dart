import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Entities/Assetentity.dart';
import 'package:flutter_application_1/Entities/Wallet_Entity.dart';
import 'package:hive/hive.dart';

class WalletsModel extends ChangeNotifier {
  List<WalletEntity> wallets = [];
  List<AssetEntity> assets = [];
  var assetBox = Hive.box<AssetEntity>('assets');
  var walletBox = Hive.box<WalletEntity>('wallets');

  WalletModel() {
    wallets = walletBox.values.toList();
    assets = assetBox.values.toList();
    notifyListeners();
  }

  _updateWallets() {
    wallets = walletBox.values.toList();
    notifyListeners();
  }

  addwallets(WalletEntity wallet) {
    walletBox.add(wallet);
    _updateWallets();
  }

  removewallets(WalletEntity wallet) {
    wallet.delete();
    _updateWallets();
  }

  addAsset(AssetEntity asset) {
    assets.add(asset);
    assetBox.add(asset);
    notifyListeners();
  }

  removeAsset(AssetEntity asset) {
    assets.removeWhere((listAsset) =>
        listAsset.name == asset.name && listAsset.amount == asset.amount);
    assetBox.delete(asset);
    asset.delete();
    notifyListeners();
  }
}
