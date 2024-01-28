import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Colors/colors.dart';
import '../../config/screen_size.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    EdgeInsets margin = calculateMargin(screenHeight, screenWidth);
    return Container(
      margin: margin,
      child: AppBar(
        leading: ImageIcon(
          const AssetImage("assets/grapewine logo medium.png"),
          color: purpleColor,
        ),
        centerTitle: true,
        title: Text(
          title,
          style: GoogleFonts.redHatDisplay(
            color: redColor,
            fontWeight: FontWeight.w900,
            fontSize: 26,
          ),
        ),
        actions: const [
          CircleAvatar(
            backgroundColor: Color(0xffE6E6E6),
            backgroundImage: AssetImage('assets/professor x pfp.jpg'),
            radius: 30,
            // child: Icon(
            //   Icons.person,
            //   color: Color(0xffCCCCCC),
            // ),
          )
        ],
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
