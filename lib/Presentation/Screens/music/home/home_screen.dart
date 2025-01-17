import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Data/Api/musicDataService.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/home/new_releases_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/library/liked_songs_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/library/recently_played_screen.dart';
import 'package:grapewine_music_app/Presentation/widgets/AppBarWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/NewReleasesWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/RecentlyPlayedWidget.dart';
import 'package:grapewine_music_app/Providers/like_provider.dart';
import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:provider/provider.dart';
import '../../../../Data/Api/MusicApisss.dart';
import '../../../../Providers/recently_played_provider.dart';
import '../../../widgets/PlaylistsTiles.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          _isDataFetched = true; // Mark the data as fetched
        }));
  }

  @override
  Widget build(BuildContext context) {
    var likeProvider = Provider.of<LikedProvider>(context, listen: true);
    var musicProvider =
        Provider.of<MusicPlayerProvider>(context, listen: false);
    var recentProvider =
        Provider.of<RecentlyPlayedProvider>(context, listen: false);
    var searchProvider = Provider.of<SearchProvider>(context, listen: false);

    return Scaffold(
      appBar: const AppBarWidget(
        title: 'HOME',
        // leading: ImageIcon(
        //   const AssetImage(""),
        //   color: purpleColor,
        // ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 7),
            child: CircleAvatar(
              backgroundColor: Color(0xffffff),
              backgroundImage: AssetImage(
                'assets/grapewine_logo.png',
              ),
              radius: 17,
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
                    Bounceable(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LikedSongsScreen(),
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: purpleColor, width: 0.4),
                            gradient: LinearGradient(
                                colors: [
                                  purpleColor, // First color (purple)
                                  eerieblackColor, // Second color (eerie black)
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomRight,
                                transform: const GradientRotation(6)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            title: Text(
                              'LIKED SONGS',
                              style: GoogleFonts.redHatDisplay(
                                color: whiteColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Text(
                              '${likeProvider.likedSongs.length} Tracks',
                              style: GoogleFonts.redHatDisplay(
                                color: whiteColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                            trailing: IconButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: redColor,
                                minimumSize: const Size(25, 25),
                              ),
                              onPressed: () async {
                                if (musicProvider.player.isPlaying.value) {
                                  await musicProvider.player.pause();
                                }
                                // Handle playlist play
                                await likeProvider.playLikedSongs(musicProvider,
                                    searchProvider, recentProvider);
                              },
                              icon: Icon(
                                musicProvider.player.isPlaying.value
                                    ? Icons.pause_outlined
                                    : Icons.play_arrow_outlined,
                                size: 25,
                              ),
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RecentlyPlayedScreen(),
                                )),
                            child: Row(
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 95,
                      child: Consumer<RecentlyPlayedProvider>(
                        builder: (context, recentlyPlayedProvider, child) {
                          final recentlyPlayedSongs = recentlyPlayedProvider
                              .recentlyPlayedSongs.reversed
                              .toList();

                          if (recentlyPlayedSongs.isEmpty) {
                            return Center(
                              child: Text(
                                "Listen to songs and check here later!",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: greyColor,
                                  // fontStyle: FontStyle.italic
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: recentlyPlayedSongs.length > 8
                                ? 8
                                : recentlyPlayedSongs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return PreviouslyPlayedCircleWidget(index: index);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                          Bounceable(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NewReleasesScreen(),
                                )),
                            child: Row(
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
                          ),
                        ],
                      ),
                    ),
                    const NewReleasesWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Playlists',
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
                    const PlaylistsWidget(),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator(color: purpleColor)),
    );
  }
}
