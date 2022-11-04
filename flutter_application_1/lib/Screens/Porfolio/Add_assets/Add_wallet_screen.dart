import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/Wallet_list_item.dart';
import 'package:flutter_application_1/Entities/Wallet_Entity.dart';
import 'package:flutter_application_1/Providers/Wallets_provider.dart';
import 'package:provider/provider.dart';

import 'package:qrscan/qrscan.dart' as scanner;

class AddWalletScreen extends StatefulWidget {
  const AddWalletScreen({Key? key}) : super(key: key);

  @override
  State<AddWalletScreen> createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<AddWalletScreen> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController _addressController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  String _symbol = '';
  String _name = '';
  String _address = '';

  _addWallet(BuildContext context) {
    _formKey.currentState?.save();
    if ([_name, _symbol, _address].contains('')) {
      return;
    }
    var wallet = WalletEntity(symbol: _symbol, name: _name, address: _address);
    var store = Provider.of<WalletsModel>(context, listen: false);
    store.addwallets(wallet);
  }

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<WalletsModel>(context);
    var Walletwidgets = store.wallets
        .map((wallet) => WalletlistItem(
            wallet: wallet,
            onPressed: () {
              store.removewallets(wallet);
            }))
        .toList();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                onSaved: (String? name) {
                  _name = name!;
                },
                decoration: InputDecoration(labelText: "Name"),
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: _addressController,
                      onSaved: (String? address) {
                        _address = address!;
                      },
                      decoration: InputDecoration(labelText: "Address"),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        String code = await scanner.scan();
                      },
                      icon: Icon(Icons.camera_alt))
                ],
              ),
              TextFormField(
                onSaved: (String? symbol) {
                  _symbol = symbol!;
                },
                decoration: InputDecoration(labelText: "symbol"),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    _addWallet(context);
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add Wallet')),
                  Expanded(child: ListView(
                    children: Walletwidgets
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
