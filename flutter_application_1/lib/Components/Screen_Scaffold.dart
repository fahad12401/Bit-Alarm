import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:flutter_application_1/Components/Bottom_navbar.dart';
import 'package:flutter_application_1/Components/Screen_headline.dart';

class ScreenScaffold extends StatelessWidget {
  final List<Widget> childern;
  final String activeNavBar;
  final String title;
  final FloatingActionButton fab;
  final Drawer drawer;

  const ScreenScaffold(
      {Key? key,
      required this.childern,
      required this.activeNavBar,
      required this.title,
      required this.fab,
      required this.drawer, floatingActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    childern.insert(
        0,
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate:
              ScreenHeaderDelegate(title: title, minExtent: 0, maxExtent: 100),
        ));
    String lightness =
        Theme.of(context).brightness == Brightness.dark ? 'dark' : 'light';

    return Scaffold(
      drawer: drawer,
      body: Stack(
        children: [
          Image(
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width + 100,
            height: MediaQuery.of(context).size.height,
            image: AssetImage('asset/images/$lightness-page-background.png'),
          ),
          CustomScrollView(
            slivers: childern,
          ),
        ],
      ),
      floatingActionButton: fab,
      bottomNavigationBar: AlarmBottomNavBar(
        active: this.activeNavBar,
      ),
    );
  }
}

class ScreenHeaderDelegate implements SliverPersistentHeaderDelegate {
  final double minExtent;
  final double maxExtent;
  final String title;

  ScreenHeaderDelegate(
      {required this.minExtent, required this.maxExtent, required this.title});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double opacity = _getOpacityForOffset(shrinkOffset);
    return Stack(
      fit: StackFit.expand,
      children: [ScreenHeadline(text: title, opacity: opacity)],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      throw UnimplementedError();

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;
  _getOpacityForOffset(double shrinkOffset) {
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  }

  @override
  TickerProvider? get vsync => null;
}
