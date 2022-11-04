import 'dart:ffi';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var _totalStyle = TextStyle(
  color: Colors.white,
  fontSize: 38,
  fontFamily: 'Oswald',
  fontWeight: FontWeight.w300,
);

class DonutChart extends StatefulWidget {
  final Map<String, double> data;
  final Map<String, double> prices;
  final Map<String, Color> colors;
  const DonutChart(
      {Key? key,
      required this.data,
      required this.prices,
      required this.colors})
      : super(key: key);

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  double _total = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _total = 0;
    if (widget.data.isEmpty) {
      return CircularProgressIndicator();
    }
    widget.data.forEach((symbol, amount) {
      double usd = widget.prices[symbol] ?? 0;
      _total += usd * amount;
    });
    return Center(
      child: Stack(
        children: [
          Container(
            width: 200,
            height: 200,
            child: Center(
              child: Text(
                '\$${_total.toStringAsFixed(2)}',
                style: _totalStyle,
              ),
            ),
          ),
          Container(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: DonutChartPainter(
                    data: widget.data,
                    prices: widget.prices,
                    colors: widget.colors,
                    total: _total),
              ))
        ],
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final Map<String, double> data;
  final Map<String, double> prices;
  final Map<String, Color> colors;
  final double total;
  DonutChartPainter(
      {required this.data,
      required this.prices,
      required this.colors,
      required this.total});

  @override
  void paint(Canvas canvas, Size size) {
    double runningTotal = 0;
    if (data.entries.length == 0) {
      var paint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeJoin = StrokeJoin.bevel;
      canvas.drawCircle(Offset(size.width / 2, size.height / 2), 2, paint);
      return;
    }
    data.forEach((Symbol, amount) {
      double price = prices[Symbol] ?? 0;
      double percent = price * amount / total;
      var paint = Paint()
        ..color = colors[Symbol] ?? Colors.white
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.bevel
        ..strokeWidth = 5;
      canvas.drawArc(
          Rect.fromLTWH(0, 0, size.width, size.height),
          runningTotal / total * math.pi * 2 - math.pi * 2 / 4,
          percent * math.pi * 2,
          false,
          paint);
      runningTotal += price * amount;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw UnimplementedError();
  }
}
