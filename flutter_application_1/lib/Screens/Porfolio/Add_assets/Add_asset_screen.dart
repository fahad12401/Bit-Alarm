import 'package:flutter/material.dart';
import 'package:flutter_application_1/Entities/Assetentity.dart';
import 'package:provider/provider.dart';

import '../../../Providers/Wallets_provider.dart';

class AddAssetScreen extends StatefulWidget {
  const AddAssetScreen({Key? key}) : super(key: key);

  @override
  State<AddAssetScreen> createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends State<AddAssetScreen> {
  var _formKey = GlobalKey<FormState>();
  String _symbol = '';
  String _name = '';
  double _amount = 0.0;

  _addAsset(BuildContext context) {
    _formKey.currentState?.save();
    var asset = AssetEntity(name: _name, amount: _amount, symbol: _symbol);
    var store = Provider.of<WalletsModel>(context, listen: false);
    store.addAsset(asset);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              onSaved: (String? symbol) {
                _symbol = symbol!.toUpperCase().trim();
              },
              decoration: InputDecoration(labelText: "symbol", hintText: 'BTC'),
            ),
            TextFormField(
              onSaved: (String? name) {
                _name = name!.trim();
              },
              decoration:
                  InputDecoration(labelText: "Name", hintText: "Bitcoin"),
            ),
            TextFormField(
              onSaved: (String? amount) {
                _amount = double.parse(amount!);
              },
              decoration:
                  InputDecoration(labelText: "Amount", hintText: '0.02'),
            ),
            ElevatedButton(
                onPressed: () {
                  _addAsset(context);
                },
                child: Text('Add asset'))
          ],
        ),
      ),
    );
  }
}
