import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Presentation/widgets/AppBarWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/NewReleasesWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/RecentlyPlayedWidget.dart';
import '../../Data/Api/MusicApisss.dart';
import '../widgets/SongsumightlikeWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _fetchAccessTokenFuture;
  bool _isDataFetched = false;

  @override
  void initState() {
    super.initState();
    if (!_isDataFetched) {
      _fetchAccessTokenFuture = _fetchAccessToken();
    }
  }

  Future<void> _fetchAccessToken() async {
    await fetchData(context); // This will initialize the access token
    setState(() {
      _isDataFetched = true; // Mark the data as fetched
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'HOME',
        leading: ImageIcon(
          const AssetImage("assets/grapewine logo medium.png"),
          color: purpleColor,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 7),
            child: CircleAvatar(
              backgroundColor: Color(0xffE6E6E6),
              backgroundImage: NetworkImage('https://i.pinimg.com/736x/3c/fe/f0/3cfef07dbfaea9c6229ec5eb4aa305e0.jpg'),
              // child: Icon(
              //   Icons.person,
              //   color: Color(0xffCCCCCC),
              // ),
            ),
          )
        ],
      ),
      body: _isDataFetched
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recently Played',
                            style: GoogleFonts.redHatDisplay(
                              color: greenColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'View All',
                                style: GoogleFonts.redHatDisplay(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                              Icon(
                                Icons.arrow_right,
                                color: whiteColor,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 90,
                      child: ListView.builder(
                        itemCount: 6,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return PreviouslyPlayedCircleWidget(index: index);
                        },
                      ),
                    ),
                   const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'New Releases',
                            style: GoogleFonts.redHatDisplay(
                              color: greenColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'View All',
                                style: GoogleFonts.redHatDisplay(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                              Icon(
                                Icons.arrow_right,
                                color: whiteColor,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return NewReleasesWidget(index: index);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Songs You Might Like',
                            style: GoogleFonts.redHatDisplay(
                              color: greenColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'View All',
                                style: GoogleFonts.redHatDisplay(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                              Icon(
                                Icons.arrow_right,
                                color: whiteColor,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SongsYouMightLikeSection(),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator(color: purpleColor)),
    );
  }
}
