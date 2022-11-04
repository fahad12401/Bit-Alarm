import 'package:flutter/material.dart';
import 'package:flutter_application_1/Entities/Wallet_Entity.dart';

class WalletlistItem extends StatelessWidget {
  final WalletEntity wallet;
  final Function onPressed;
  const WalletlistItem(
      {Key? key, required this.wallet, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${wallet.name} - ${wallet.symbol.toUpperCase()}"),
      subtitle: Text(wallet.address),
      trailing: IconButton(
        icon: Icon(Icons.remove_circle),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
