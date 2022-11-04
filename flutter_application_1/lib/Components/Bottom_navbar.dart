import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

import '../Screens/Favourites/Favourite_Screen.dart';
import '../Screens/Porfolio/Add_assets/Porfolio_screen.dart';
import '../Screens/Porfolio/Toplist/toplist_screen.dart';

class AlarmBottomNavBar extends StatelessWidget {
  final String active;
  const AlarmBottomNavBar({Key? key, required this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
            activeIcon: Icon(Icons.favorite)),
        BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All',
            activeIcon: Icon(Icons.trending_up)),
        BottomNavigationBarItem(
            icon: Icon(Icons.donut_large),
            label: 'Porfolio',
            activeIcon: Icon(Icons.donut_small)),
      ],
      currentIndex: ['favorites', 'toplist', 'porfolio']
          .indexWhere((element) => element == active),
      onTap: (int i) {
        int currentIndex = ['favorites', 'toplist', 'porfolio']
            .indexWhere((element) => element == active);
        if (currentIndex == i) {
          return;
        }
        Widget screen =
            [FavoriteScreen(), TopListScreen(), PorfolioScreen()][i];
        routePush(screen, RouterType.material);
      },
    );
  }
}
