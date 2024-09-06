import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Colors/colors.dart';
import '../../config/screen_size.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });

  final String title;
  final Widget? leading; // Make leading a parameter
  final List<Widget>? actions; // Make actions a parameter

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    EdgeInsets margin = calculateMargin(screenHeight, screenWidth);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AppBar(
        leading: leading,
        centerTitle: true,
        title: Text(
          title,
          style: GoogleFonts.redHatDisplay(
            color: redColor,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        actions: actions,
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
