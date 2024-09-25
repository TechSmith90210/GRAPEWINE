import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:provider/provider.dart';

import '../../Providers/navigator_provider.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigatorProvider>(
      builder: (context, navigatorProvider, child) {
        return NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: blackColor,
            indicatorColor: eerieblackColor,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            labelTextStyle: MaterialStateProperty.resolveWith((states) {
              // Change text color when a navigation destination is clicked
              if (states.contains(MaterialState.selected)) {
                return GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w700,
                  color: whiteColor,
                  fontSize: 12,
                );
              } else {
                return GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w500,
                  color: greyColor,
                  fontSize: 12,
                );
              }
            }),
            elevation: 0,
            iconTheme: MaterialStateProperty.all(
              IconThemeData(
                  color: greyColor),
            ),
          ),
          child: NavigationBar(

            selectedIndex: navigatorProvider.selectedIndex,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home, color: whiteColor),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.search),
                selectedIcon: Icon(
                  Icons.search,
                  color: whiteColor,
                ),
                label: 'Search',
              ),
              NavigationDestination(
                icon: Icon(Icons.library_music_outlined),
                selectedIcon: Icon(
                  Icons.library_music,
                  color: whiteColor,
                ),
                label: 'Library',
              ),
            ],
            onDestinationSelected: (int value) {
              navigatorProvider.navigatePage(value);
            },
          ),
        );
      },
    );
  }
}
