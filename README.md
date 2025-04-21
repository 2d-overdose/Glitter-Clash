# Shooting Game

A magical Flutter game where players pick a fairy and use character-specific missiles to defeat enemies across multiple levels! Fire spells, dodge bosses, and shake your phone to reload in this motion-enhanced arcade shooter.

The project is available in GitLab and GitHub, due to restrictions in sharing the GitLab repository. The GitHub repository contains all the final files and serves as a way to share the project with users outside of my institution (university). Commit history is only available on GitLab since the project was developed there and the full repository history failed to clone on GitHub. 

## Features

- Character Selection – Choose between unique fairy characters, each with their own custom missile.
- Missile Mechanics – Fire vertically at moving enemies with tight collision detection.
- Dynamic Levels – 3 increasing levels of difficulty, each with its own enemy behavior:
  - Level 1: Hit one enemy 3 times
  - Level 2: Hit two enemies, each twice
  - Level 3: Boss battle with Espera — avoid her while hitting her twice!
- Reload System – Shake your device to reload after running out of missiles.
- Simple Controls – Use on-screen arrows and fire button.
- Deadly Collisions – Touching the enemy ends the game instantly on Level 3.
- Motion Detection – Reloading works via accelerometer-based shake gesture.
- State Management – Efficient game logic using `Provider`.

## Getting Started

### Prerequisites

- Flutter SDK (3.7.0 or higher)
- Xcode (for iOS)
- Android Studio (for Android)
- Physical or virtual device (iOS or Android)

### Installation

1. Clone the repository
bash
git clone https://github.com/yourusername/shooting_game.git
cd shooting_game

2. Install dependencies
bash
flutter pub get

3. iOS Setup
bash
cd ios
pod install
cd ..

4. Run the app
bash
flutter run

### Platform-Specific Setup

#### iOS
1. Open Xcode:
bash
cd ios
open Runner.xcworkspace

2. In Xcode:
- Select "Runner" in the project navigator
- Select "Runner" target
- Go to "Signing & Capabilities"
- Check "Automatically manage signing"
- Select your development team
- Update bundle identifier if needed

3. Add motion sensor permissions to `ios/Runner/Info.plist`:
xml
<key>NSMotionUsageDescription</key>
<string>This application needs to access motion sensor data</string>

#### Android
Add the following permission to `android/app/src/main/AndroidManifest.xml`:
xml
<uses-permission android:name="android.permission.VIBRATE"/>

## Game Controls

- **Left Arrow**: Move player left
- **Right Arrow**: Move player right
- **Up Arrow**: Fire missile
- **Shake Device**: Reload missiles when prompted

## Game Rules

Level 1
Hit the enemy 3 times.
You get 3 missiles per reload and 2 reloads.

Level 2
Two enemies: hit each 2 times.
3 missiles per reload and 2 reloads.

Level 3
Boss fight with Espera.
Hit her 2 times without touching her.
Touching her = instant game over.

All levels:
Shake to reload
After 3 reloads without success = restart
Game ends after Level 3 with a win or defeat

## Project Structure

lib/
├── main.dart
├── screens/
│   ├── choose_fairy.dart      # Character selection UI
│   ├── game_screen_1.dart     # Main game UI
│   ├── game_screen_2.dart     # Main game UI
│   ├── game_screen_3.dart     # Main game UI
│   ├── rules_screen.dart      # Main game UI
│   └── welcome_page.dart      # Main game UI
├── models/
│   ├── fairy_state.dart       # Fairy + missile state
│   ├── game_state.dart        # Abstract game logic
│   ├── game_state_1.dart      # Level 1 logic
│   ├── game_state_2.dart      # Level 2 logic
│   └── game_state_3.dart      # Level 3 logic
├── widgets/
│   ├── game_objects/
│   │   ├── bird.dart          # Enemy types
│   │   ├── missile.dart       # Missile visuals
│   │   └── player.dart        # Player fairy sprite
│   └── ui/
│       ├── game_button.dart          # UI buttons
│       ├── game_dialogs.dart         # Win/Loss/Restart dialogs
│       ├── play_with_character.dart  # Win/Loss/Restart dialogs
│       └── missile_counter.dart      # UI ammo tracker
└── utils/
    └── position_helper.dart   # Helper for coordinate logic


## Dependencies

- `flutter_sdk`: Core Flutter framework
- `motion_sensors`: ^0.1.0 - Device motion detection
- `provider`: ^6.1.1 - State management
- `cupertino_icons`: ^1.0.8 - iOS style icons

## Building for Release

### Android
bash
flutter build apk --release

### iOS
bash
flutter build ios --release
cd ios
xcodebuild -workspace Runner.xcworkspace -scheme Runner -configuration Release archive

## Troubleshooting

### Common Issues

1. **Sensor Issues**
   - Ensure device permissions are granted
   - Check device motion sensor functionality

2. **Build Errors**
   - Run `flutter clean`
   - Delete build folders
   - Re-run `flutter pub get`

3. **iOS Signing Issues**
   - Verify Apple Developer account
   - Check provisioning profiles
   - Update bundle identifier

## Contributing
Not accepting contributions.

## Acknowledgments
- Flutter team for the framework
- Inspiration for the project: https://youtu.be/ZBLOxhiym7k?si=bvvWXtuOlXtR133F
- Help on coding bugs from: https://chatgpt.com

## Support
If support is needed, you can contact me via E-mail: 528614@student.fontys.nl.

## Roadmap
No future releases.

## Author
Nikol Galabova
