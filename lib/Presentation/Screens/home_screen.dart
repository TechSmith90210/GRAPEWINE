import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const Center(
          child: Text(
            'Learn 📗',
          ),
        ),
        const Center(
          child: Text(
            'Relearn 👨‍🏫',
          ),
        ),
        const Center(
          child: Text(
            'Unlearn 🐛',
          ),
        ),
      ][_selectedIndex],
      bottomNavigationBar:
      NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(
              icon: Icon(Icons.favorite_border_sharp), label: 'Liked Songs'),
        ],
        onDestinationSelected: (int value) {
          setState(() {
            _selectedIndex = value;
          });
          print(_selectedIndex);
        },
      ),
    );
  }
}
