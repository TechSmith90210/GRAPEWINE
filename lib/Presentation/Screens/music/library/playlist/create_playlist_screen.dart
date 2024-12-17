import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Providers/playlist_provider.dart';
import 'package:grapewine_music_app/models/playlist.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Presentation/widgets/AppBarWidget.dart';
import 'package:provider/provider.dart';

class CreatePlaylistScreen extends StatefulWidget {
  const CreatePlaylistScreen({super.key});

  @override
  State<CreatePlaylistScreen> createState() => _CreatePlaylistScreenState();
}

class _CreatePlaylistScreenState extends State<CreatePlaylistScreen> {
  File? selectedImage;
  TextEditingController playlistnameController = TextEditingController();

  @override
  void dispose() {
    playlistnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard on tap outside
      child: Scaffold(
        appBar: AppBarWidget(
          title: 'Create Playlist',
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            color: whiteColor,
          ),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Bounceable(
                  onTap: _pickImageFromGallery,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: selectedImage != null ? null : Colors.grey[700],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: selectedImage != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(
                        selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                        : const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white70,
                      size: 50,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: playlistnameController,
                  style:  TextStyle(color: whiteColor),
                  decoration: InputDecoration(
                    hintText: 'Enter Playlist Name',
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 0.3, color: Colors.white70),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 0.3, color: Colors.white70),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(width: 1, color: redColor),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(320, 56),
                    backgroundColor: redColor,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    final provider = Provider.of<PlaylistProvider>(context, listen: false);
                    final existingPlaylistNames = provider.playlists.map((e) => e.playlistName.toLowerCase()).toList();

                    if (playlistnameController.text.isNotEmpty) {
                      final playlistName = playlistnameController.text.trim();

                      // Check if the playlist name already exists
                      if (existingPlaylistNames.contains(playlistName.toLowerCase())) {
                        // Show SnackBar if the playlist name already exists
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Playlist name already exists. Please choose another name.'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      } else {
                        // Create the playlist if the name is unique
                        String? imageUrl = selectedImage?.path;
                        Playlist playlist = Playlist(
                          playlistName: playlistName,
                          imageUrl: imageUrl ?? '', // Provide a default value if null
                        );

                        provider.createPlaylist(playlist);
                        print(provider.playlists.map((e) => e.playlistName).toList());
                        Navigator.pop(context); // Navigate back after creating the playlist
                      }
                    } else {
                      // Show SnackBar if the playlist name is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Please enter a playlist name.'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Create Playlist',
                    style: GoogleFonts.redHatDisplay(
                      color: whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      setState(() {
        selectedImage = File(returnedImage.path);
      });
    }
  }
}
