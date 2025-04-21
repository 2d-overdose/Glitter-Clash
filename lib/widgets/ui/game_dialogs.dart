import 'package:flutter/material.dart';
import '../../models/game_state.dart';
import '../../models/fairy_state.dart';
import 'package:provider/provider.dart';

// Page consisting of the code behind how the info dialogs look like

void showReloadDialog(BuildContext context, GameState gameState) {
  // Set the flag to true when the dialog is shown
  gameState.isPopupOpen = true;

  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissing without shaking
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Image.asset('assets/images/shake_dialogue.png'),
      );
    },
  ).then((_) {
    // Set flag to false when dialog is dismissed
    gameState.isPopupOpen = false;
  });
}

// show a dialog that informs the player that the game is fully over, you passed all of the levels 
void showGameOverDialog(BuildContext context, GameState gameState) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Image.asset('assets/images/end_game_dialogue.png'),
        actions: [
          //on button press restart the whole game (aka return to choose a fairy screen)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              gameState.restartWholeGame(context);
            },
            child: Text(
              "Restart Game?",
              style: TextStyle(
                fontFamily: 'Jersey',
                color: Color(0xFFDD5B75),
                fontSize: 30,
              ),
            ),
          ),
        ],
      );
    },
  );
}

// show a dialog that informs the player that the level is over, you didnt succeed with the reloads you have
void showRestartDialog(BuildContext context, GameState gameState) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Image.asset('assets/images/no_energy_dialogue.png'),
        actions: [
        //on button press restart the level
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              gameState.restartGame();
            },
            child: Text(
              "Restart Level",
              style: TextStyle(
                fontFamily: 'Jersey',
                color: Color(0xFFDD5B75),
                fontSize: 30,
              ),
            ),
          ),
        ],
      );
    },
  );
}

// show a dialog that informs the player that the 3 level is over, due to the monster touching you 
void showDeadDialog(BuildContext context, GameState gameState) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Image.asset('assets/images/dead_dialogue.png'),
        actions: [
          TextButton(
            onPressed: () {
            //on button press restart the level
              Navigator.of(context).pop();
              gameState.restartGame();
            },
            child: Text(
              "Restart Level",
              style: TextStyle(
                fontFamily: 'Jersey',
                color: Color(0xFFDD5B75),
                fontSize: 30,
              ),
            ),
          ),
        ],
      );
    },
  );
}

// show a dialog that informs the player that the level is over, and they get to move up to the next level 
void showLevelUpDialog(BuildContext context, GameState gameState) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Image.asset('assets/images/new_level_dialogue.png'),
        actions: [
          TextButton(
            onPressed: () {
              // Get the selected character ONLY when the button is pressed
              // move to the next level on button press
              final fairyState = Provider.of<FairyState>(
                context,
                listen: false,
              );
              String selectedCharacter =
                  fairyState.characterImages[fairyState.selectedCharacterIndex];
              Navigator.of(context).pop();
              gameState.completeLevel(context, selectedCharacter);
            },
            child: Text(
              "New Level",
              style: TextStyle(
                fontFamily: 'Jersey',
                color: Color(0xFFDD5B75),
                fontSize: 30,
              ),
            ),
          ),
        ],
      );
    },
  );
}
