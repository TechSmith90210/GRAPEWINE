import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Presentation/widgets/BottomNavBarWidget.dart';
import 'package:provider/provider.dart';

import '../../Providers/navigator_provider.dart';

class TheMusicPages extends StatefulWidget {
  const TheMusicPages({Key? key});

  @override
  State<TheMusicPages> createState() => _TheMusicPagesState();
}

class _TheMusicPagesState extends State<TheMusicPages> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigatorProvider>(
      builder: (context, navigatorProvider, child) {
        return Scaffold(
          body: [
            const Center(child: Text('Learn 📗')),
            const Center(child: Text('Relearn 👨‍🏫')),
            const Center(child: Text('Unlearn 🐛')),
          ][navigatorProvider.selectedIndex],
          bottomNavigationBar: BottomNavBarWidget(),
          // bottomNavigationBar: NavigationBar(
          //   selectedIndex: navigatorProvider.selectedIndex,
          //   destinations: const [
          //     NavigationDestination(
          //         icon: Icon(Icons.home_outlined), label: 'Home'),
          //     NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          //     NavigationDestination(
          //         icon: Icon(Icons.favorite_border_sharp),
          //         label: 'Liked Songs'),
          //   ],
          //   onDestinationSelected: (int value) {
          //     navigatorProvider.navigatePage(value);
          //   },
          // ),
        );
      },
    );
  }
}
