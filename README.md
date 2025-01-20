![grapewine_header](https://github.com/user-attachments/assets/e2c0d079-1478-4f7a-9272-1fe838c37b7d)

# Grapewine Music App
Grapewine Music is an open-source Flutter-based music streaming application designed for advanced playlist customization and seamless music discovery. It leverages the Spotify API, `assets_audio_player` for playback, and `isar` for efficient storage and retrieval. Powered by `Provider` for scalable state management, Grapewine Music delivers a responsive and user-centric experience.

## Features

- ✨ **Elegant UI:** Sleek and modern interface crafted with custom color themes and Google Fonts for a polished look.
- 📝 **Advanced Playlist Management:** Customize playlists with ease and organize music collections.
- 🔄 **Recently Played:** Smart tracking and display of recently played tracks for quick access.
- 🔍 **Advanced Search:** Instant search functionality for songs, albums, and artists.
- 🛠️ **Scalable State Management:** Managed by `Provider` for reactive, maintainable, and scalable state handling.

## Installation

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/yourusername/grapewine_music_app.git
   ```
2. **Navigate to the Project Directory:**
   ```bash
   cd grapewine_music_app
   ```
3. **Install Dependencies:**
   ```bash
   flutter pub get
   ```
4. **Create the `CustomStrings.dart` File:**
   Inside the `lib` directory, create a file named `CustomStrings.dart` with the following structure:
   ```dart
   class CustomStrings {
     static const String clientId = ;
     static const String clientSecret = ;
   }
   ```
   Replace the placeholders with your Spotify API credentials.
5. **Run the App:**
   ```bash
   flutter run
   ```

## Project Structure

```
grapewine_music_app/
├── lib/
│   ├── authentications/       # Authentication services and logic
│   ├── Colors/                # App color themes
│   ├── config/                # Configuration files and environment setup
│   ├── data/                  # Data services and local storage helpers
│   ├── models/                # Data models (Song, Playlist, etc.)
│   ├── presentation/          # UI presentation and screens
│   ├── providers/             # State management providers
│   ├── utilities/             # Utility functions
│   ├── CustomStrings.dart     # Centralized custom strings
│   └── main.dart              # App entry point
├── assets/                   # Images, icons, and audio assets
├── pubspec.yaml              # Dependency and configuration file
└── README.md                 # Project documentation
```

## Dependencies

- [`provider`](https://pub.dev/packages/provider) - State management
- [`assets_audio_player`](https://pub.dev/packages/assets_audio_player) - Audio playback
- [`isar`](https://pub.dev/packages/isar) - Local storage and data retrieval
- [`google_fonts`](https://pub.dev/packages/google_fonts) - Custom fonts
- [`flutter_bounceable`](https://pub.dev/packages/flutter_bounceable) - Bounce animations

## Contribution Guidelines

- A **Spotify Developer Account** is required to contribute to this project.
- Cloud sync features (e.g., Firebase integration) are a **TODO** item and will include advanced synchronization capabilities in the future.
- This project has been an on-and-off endeavor; as a result, the code quality may vary. Suggestions and contributions are welcome to enhance the project further.
- Please report bugs or suggest improvements by opening issues in the **Issues** section.
- Contributions to fix bugs or add features are welcome!

### How to Contribute

1. Fork the repository.
2. Create a dedicated branch for your feature or bugfix.
3. Commit and push your changes.
4. Open a pull request for review.

## Future Enhancements

- 🌐 **Theme Customization:** Dark/Light mode toggle for personalized themes.
- 🔀 **Playlist Reordering:** Drag-and-drop playlist reordering feature.
- 🛠️ **Smart Recommendations:** AI-powered song recommender system.
- ☁️ **Cloud Sync:** Integrate Firebase for cross-device synchronization.

## License

This project is licensed under the MIT License.

---

Engineered with precision and passion in Flutter.

