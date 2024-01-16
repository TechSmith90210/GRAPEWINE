import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Providers/navigator_provider.dart';

import '../widgets/BottomNavBarWidget.dart';

class TheMusicPages extends StatefulWidget {
  const TheMusicPages({super.key});

  @override
  State<TheMusicPages> createState() => _TheMusicPagesState();
}

class _TheMusicPagesState extends State<TheMusicPages> {
  @override
  Widget build(BuildContext context) {
    print('IAmMusic');
    return Scaffold(
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}
