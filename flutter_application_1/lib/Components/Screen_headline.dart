import 'package:flutter/material.dart';
import 'package:flutter_application_1/Shared/style.dart';

class ScreenHeadline extends StatelessWidget {
  final String text;
  final double opacity;
  const ScreenHeadline({Key? key, required this.text, required this.opacity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: "Oswald",
        fontSize: 110,
        fontWeight: FontWeight.w600,
        height: 1,
        letterSpacing: 1.5,
        color: COLOR_HEADLINE.withOpacity(opacity));
    return Positioned(
      left: -20,
      top: -5,
      child: Text(
        text.toUpperCase(),
        overflow: TextOverflow.fade,
        style: style,
        softWrap: false,
      ),
    );
  }
}
