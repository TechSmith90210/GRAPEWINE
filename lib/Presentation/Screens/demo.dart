import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import '../widgets/SearchWidgets.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  late Future<void> fetchDataFuture;

  @override
  void initState() {
    fetchDataFuture = searchforData(context, 'Beyon');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: fetchDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      // var imageUrl =
                      //     provider.searchArtistImages[index].toString();
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: purpleColor,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return TrackWidget(context, index);
                      }
                      return null;
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: purpleColor,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
