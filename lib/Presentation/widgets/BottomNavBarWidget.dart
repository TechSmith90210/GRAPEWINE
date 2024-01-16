import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/navigator_provider.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigatorProvider = Provider.of<NavigatorProvider>(context);

    return NavigationBar(
      selectedIndex: navigatorProvider.selectedIndex,
      destinations: const [
        NavigationDestination(
            icon: Icon(Icons.home_outlined), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
        NavigationDestination(
            icon: Icon(Icons.favorite_border_sharp), label: 'Liked Songs'),
      ],
      onDestinationSelected: (int value) {
        navigatorProvider.navigatePage(value);
      },
    );
  }
}
