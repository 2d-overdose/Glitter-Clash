import 'package:flutter/material.dart';
import 'package:shooting_game/models/game_state_1.dart';
import 'package:shooting_game/screens/game_screen_1.dart';

// A page containing the functionality behing the choosing a fairy system

class FairyState extends ChangeNotifier {
  int selectedCharacterIndex = 0;
  final PageController pageController = PageController();

  // List of possible character choices
  final List<String> characterImages = [
    'assets/images/pink_fairy.png',
    'assets/images/purple_fairy.png',
    'assets/images/green_fairy.png',
  ];

  // List of possible missile choices
  final List<String> missileImages = [
    'assets/images/pink_missile.png',
    'assets/images/purple_missile.png',
    'assets/images/green_missile.png',
  ];

  // Method to set the selected character externally (for level transitions)
  void setSelectedCharacter(String character) {
    int index = characterImages.indexOf(character);
    if (index != -1) {
      selectedCharacterIndex = index;
      notifyListeners();
    }
  }

  // Button redirecting you to the playable game after selecting a character
  void goToNextPage(BuildContext context) {
    print("Selected index: $selectedCharacterIndex");
    print("Selected character: ${characterImages[selectedCharacterIndex]}");
    print("Selected missile: ${missileImages[selectedCharacterIndex]}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => GameScreen(
              selectedCharacter: characterImages[selectedCharacterIndex],
              gameState: GameState1(
                selectedCharacter: characterImages[selectedCharacterIndex],
                selectedMissile: missileImages[selectedCharacterIndex],
              ),
            ),
      ),
    );
  }

  // Viewing the previous option for character
  void goToPreviousCharacter() {
    if (selectedCharacterIndex > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  // Viewing the next option for character
  void goToNextCharacter() {
    if (selectedCharacterIndex < characterImages.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  // "Lock in" the selected character
  void onPageChanged(int index) {
    selectedCharacterIndex = index;
    notifyListeners();
  }
}
