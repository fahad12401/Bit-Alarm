import 'package:flutter/material.dart';

enum SortProperty { PRICE, GAIN, LOSE }
TextStyle activestyle = TextStyle(color: Colors.white);
TextStyle inactivestyle = TextStyle(color: Colors.black);

class SortButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final bool active;
  SortButton(this.label, {required this.onPressed, this.active = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onPressed();
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x333333),
                spreadRadius: 4,
                blurRadius: 4,
              )
            ],
            borderRadius: BorderRadius.circular(48),
            color: active ? Colors.blue : Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 6, 24, 6),
            child: Text(label, style: active ? activestyle : inactivestyle),
          ),
        ));
  }
}

class SortButtonGroup extends StatelessWidget {
  final Function onSort;
  final SortProperty active;

  SortButtonGroup({Key? key, required this.onSort, required this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SortButton(
          "Price",
          active: active == SortProperty.PRICE,
          onPressed: () {
            onSort(SortProperty.PRICE);
          },
        ),
        SortButton(
          "Gain",
          active: active == SortProperty.GAIN,
          onPressed: () {
            onSort(SortProperty.GAIN);
          },
        ),
        SortButton(
          "Loss",
          active: active == SortProperty.LOSE,
          onPressed: () {
            onSort(SortProperty.LOSE);
          },
        )
      ],
    );
  }
}
