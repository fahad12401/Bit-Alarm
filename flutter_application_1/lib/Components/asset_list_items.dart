import 'package:flutter/material.dart';
import 'package:flutter_application_1/Entities/Assetentity.dart';

var _amountstyle = TextStyle(
    fontSize: 23, fontWeight: FontWeight.normal, fontFamily: 'Oswald');
var _namestyle = TextStyle(
    fontSize: 16,
    fontFamily: 'Oswald',
    fontWeight: FontWeight.w100,
    color: Colors.white.withOpacity(0.5),
    letterSpacing: 1.5);

class AssetListItems extends StatefulWidget {
  final AssetEntity asset;
  AssetListItems({required this.asset});

  @override
  State<AssetListItems> createState() => _AssetListItemsState();
}

class _AssetListItemsState extends State<AssetListItems> {
  @override
  Widget build(BuildContext context) {
    var assetName = widget.asset.name.length > 9
        ? widget.asset.name.substring(0, 9)
        : widget.asset.name;
    var nameSum = widget.asset.name
            .split('')
            .map((char) => char.codeUnitAt(0))
            .reduce((value, element) => value + element) *
        100000;
    nameSum.toRadixString(16);
    return Container(
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(1),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.asset.toString(),
                style: _amountstyle,
                overflow: TextOverflow.clip,
              ),
              Text(
                assetName.toUpperCase(),
                style: _namestyle,
                softWrap: true,
                overflow: TextOverflow.fade,
              )
            ],
          ))
        ],
      ),
    );
  }
}
