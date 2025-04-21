import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../models/fairy_state.dart';
import '../models/game_state_1.dart';
import '../models/game_state_2.dart';
import '../widgets/game_objects/bird.dart';
import '../widgets/game_objects/missile.dart';
import '../widgets/game_objects/player.dart';
import '../widgets/ui/missile_counter.dart';
import '../widgets/ui/game_button.dart';

// Page that consists of the UI behind the playable game. Consists of a playing view (the caracter, the target, the missle and a missile fired counter) and game controlls (left, right and shoot)

class GameScreen extends StatefulWidget {
  final String selectedCharacter;
  final GameState gameState;

  const GameScreen({
    super.key,
    required this.selectedCharacter,
    required this.gameState,
  });

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  late GameState _gameState;

  @override
  void initState() {
    super.initState();
    _gameState = widget.gameState; // use the passed (current) game state

    // Set the selected character in FairyState
    Future.delayed(Duration.zero, () {
      final fairyState = Provider.of<FairyState>(context, listen: false);
      fairyState.setSelectedCharacter(
        widget.selectedCharacter,
      ); // Set the character
    });

    _gameState.initShakeDetector(context);

    // Start the game after a 3-second delay
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        // Ensure the widget is still in the tree before calling setState
        _gameState.startCountdown(context);
      }
    });
  }

  @override
  void dispose() {
    _gameState.dispose();
    super.dispose();
  }

  void completeLevel(BuildContext context) {
    if (_gameState is GameState1) {
      (_gameState as GameState1).completeLevel(
        context,
        widget.selectedCharacter,
      );
    } else if (_gameState is GameState2) {
      // Handle future levels if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _gameState,
      child: Consumer<GameState>(
        builder: (context, gameState, _) {
          print('missile used: ${gameState.selectedMissile}');
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      // Background image
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          // Background image
                          image: AssetImage("assets/images/screen.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Stack(
                          children: [
                            // Target showing
                            MyBird1(
                              birdX: gameState.birdX,
                              birdY: gameState.birdY,
                            ),
                            // Missle showing
                            MyMissile(
                              missileX: gameState.missileX,
                              missileY: gameState.missileY,
                              missileImagePath: gameState.selectedMissile,
                            ),
                            // Player showing
                            MyPlayer(
                              playerX:
                                  gameState
                                      .playerX, // Position of the character
                              characterImage: widget.selectedCharacter,
                              playerY: gameState.playerY,
                            ), // Use the passed selected character image
                            MyMissileCounter(
                              missileCount: gameState.missileCount,
                              level: gameState.level,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    // Game controlls pannel
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFDD5B75), width: 3),
                        color: Color(0xFFF1CBE2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Move left button
                          GameButton(
                            imageB: ('assets/images/button_left.png'),
                            function: () => gameState.moveLeft(),
                          ),
                          // Fire missle button
                          GameButton(
                            imageB: ('assets/images/button_up.png'),
                            function: () => gameState.fireMissile(context),
                          ),
                          // Move right button
                          GameButton(
                            imageB: ('assets/images/button_right.png'),
                            function: () => gameState.moveRight(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Countdown Overlay
              if (gameState.showCountdown)
                Center(
                  child: Text(
                    '${gameState.countdown}',
                    style: TextStyle(
                      fontSize: 80,
                      color: Color(0xFFDD5B75),
                      decoration: TextDecoration.none,
                      fontFamily: 'Jersey',
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
