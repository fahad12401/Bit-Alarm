import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/Coin/Coingraph_label.dart';

class CoinGraph extends StatelessWidget {
  final List<double> data;
  const CoinGraph({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bound) {
        return LinearGradient(
            stops: [0, 0, 7],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(86, 116, 228, 1),
              Color.fromRGBO(200, 104, 104, 1),
            ]).createShader(bound);
      },
      child: CustomPaint(
        painter: CoinChartPainter(22, 33, data),
      ),
    );
  }
}

class CoinChartPainter extends CustomPainter {
  final List<double> data;
  double _max;
  double _min;

  CoinChartPainter(this._max , this._min , this.data) {
    if (data.length > 0) {
      _max = data.reduce((peak, current) => max(peak, current));
      _min = data.reduce((valley, current) => min(valley, current));
    }
  }

  @override
  bool shouldRepaint(CoinChartPainter old) => true;

  double _y(double value, double height) {
    var weight = height / (_max - _min);
    return height - (value - _min) * weight;
  }

  double _x(int index, double width) => index / data.length * width;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length == 0) {
      return;
    }
    var width = size.width;
    var height = size.height;

    Path path = Path();

    path.moveTo(0, _y(data[0], height));
    for (var i = 1; i < data.length; i++) {
      var value = data[i];
      double x = _x(i, width);
      double y = _y(value, height);
      path.lineTo(x, y);
    }

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }
}
