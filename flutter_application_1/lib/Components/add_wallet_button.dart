import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nav_router/nav_router.dart';

import '../Screens/Porfolio/Add_assets/Add_asset_screen.dart';
import '../Screens/Porfolio/Add_assets/Add_wallet_screen.dart';

class AddWalletButton extends StatelessWidget {
  void _navigatetoManageWallet() {
    routePush(AddWalletScreen());
  }

  void _navigatetoManageAssets() {
    routePush(AddAssetScreen());
  }

  _showBottomSheet(BuildContext context) {
    Widget button(
        {required String label,
        required String text,
        required Icon icon,
        required Function onTap}) {
      return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              border: Border.all(
                width: 1,
                color: Colors.white.withOpacity(.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 8), child: icon),
                        Text(
                          label.toUpperCase(),
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Oswald',
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )),
                Text(
                  text,
                  style: TextStyle(fontSize: 10),
                )
              ],
            )),
      );
    }

    showBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return Container(
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                button(
                    label: 'Manage Wallet',
                    text:
                        'Wallet will find all coins and tokens that belong to them and automatically keep your porfolio upto Date.',
                    onTap: _navigatetoManageAssets,
                    icon: Icon(
                      Icons.attach_money,
                      size: 18,
                    ))
              ],
            ),
          );
        });
  }

  const AddWalletButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(color: Colors.white.withOpacity(.5));
    return Container(
      width: 180,
      child: TextButton(
          onPressed: () {
            _showBottomSheet(context);
          },
          child: Text(
            'Manage Assets',
            style: style,
          )),
    );
  }
}
