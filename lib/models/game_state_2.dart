import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:shooting_game/models/game_state.dart';
import 'package:shooting_game/models/game_state_3.dart';
import 'package:shooting_game/screens/game_screen_3.dart';
import '../widgets/ui/game_dialogs.dart';
import '../utils/position_helper.dart';

// A page containing the functionality behind the playable game system

class GameState2 extends GameState {
  StreamSubscription? _subscription;
  final String selectedCharacter;

  Random _random = Random();

  // Bird 1 variables (same as before)
  double bird1X = 0.7;
  double bird1Y = 1;
  Direction bird1Direction = Direction.left;
  bool bird1Active = true; // To remove the bird if it's hit twice

  // Bird 2 variables (new bird moving in the opposite direction)
  double bird2X = -0.6; // Starts from the left
  double bird2Y = 1;
  Direction bird2Direction = Direction.right;
  bool bird2Active = true; // To remove the bird if it's hit twice

  int bird1Hits = 0; // Track hits on Bird 1
  int bird2Hits = 0; // Track hits on Bird 2

  GameState2({required this.selectedCharacter, required String selectedMissile})
      : super(level: 2) {
    this.selectedMissile = selectedMissile;
  }

  // countdown timer variables
  int _countdown = 3;
  bool _showCountdown = false;

  @override
  // Start countdown before game begins
  void startCountdown(BuildContext context) {
    _countdown = 3;
    _showCountdown = true;
    notifyListeners();

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        _countdown--;
      } else {
        timer.cancel();
        _showCountdown = false;
        startGame(context); // Start game after countdown
      }
      notifyListeners();
    });
  }

  @override
  // Listener for a phone shake that will reset the missle counter and remove the info screen
  void initShakeDetector(BuildContext context) {
    _subscription = motionSensors.accelerometer.listen((event) {
      final acceleration =
          event.x * event.x + event.y * event.y + event.z * event.z;
      if (acceleration > 250 && isPopupOpen) {
        // Shake threshold while the popup is open
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
          resetCounter(context);
          isPopupOpen = false; // Close popup and disable shake reset
        }
      }
    });
  }

  @override
  // Target moving algorithm that allows the target to move left and right. The movement depends on the target hitting a wall.
  void startGame(BuildContext context) {
    double time = 0;
    double height = 0;
    double velocity = 90;

    // Initial random positions for the birds
    bird1X = _random.nextDouble() * 2 - 1; // Random position between -1 and 1
    bird1Y = _random.nextDouble() * 2 - 1; // Random position between -1 and 1
    bird1Direction =
        _random.nextBool()
            ? Direction.left
            : Direction.right; // Random direction

    bird2X = _random.nextDouble() * 2 - 1; // Random position between -1 and 1
    bird2Y = _random.nextDouble() * 2 - 1; // Random position between -1 and 1
    bird2Direction =
        _random.nextBool()
            ? Direction.left
            : Direction.right; // Random direction

    Timer.periodic(Duration(milliseconds: 20), (timer) {
      height = -5 * time * time + velocity * time;

      if (height < 0) {
        time = 0;
      }

      bird1Y = heightToPosition(height + 20, context);
      bird2Y = heightToPosition(height - 20, context);
      notifyListeners();

      // Move Bird 1
      if (bird1Active) {
        if (bird1X - 0.008 < -1) {
          bird1Direction = Direction.right;
        } else if (bird1X + 0.008 > 1) {
          bird1Direction = Direction.left;
        }
        bird1X += bird1Direction == Direction.left ? -0.008 : 0.008;
      }

      // Move Bird 2
      if (bird2Active) {
        if (bird2X - 0.004 < -1) {
          bird2Direction = Direction.right;
        } else if (bird2X + 0.004 > 1) {
          bird2Direction = Direction.left;
        }
        bird2X += bird2Direction == Direction.left ? -0.004 : 0.004;
      }

      time += 0.1;
      notifyListeners();
    });
  }

  @override
  // Moving the player to the left by clicking the left arrow
  void moveLeft() {
    if (playerX - 0.1 >= -1) {
      playerX -= 0.1;
      if (!midShot) {
        missileX = playerX;
      }
      notifyListeners();
    }
  }

  @override
  // Moving the player to the right by clicking the right arrow
  void moveRight() {
    if (playerX + 0.1 <= 1) {
      playerX += 0.1;
      if (!midShot) {
        missileX = playerX;
      }
      notifyListeners();
    }
  }

  @override
  // Adding a new missle to the position of the character
  void resetMissile() {
    missileX = playerX;
    missileY = 1;
    midShot = false;
    notifyListeners();
  }

  @override
  // Resetting the missle fired count after phone shake
  void resetCounter(BuildContext context) {
    missileCount = 0;
    resets++;
    if (resets >= 3) {
      showRestartDialog(context, this);
      return;
    }
    notifyListeners();
  }

  @override
  // Firing the missle on button click. The missle consists of a pole that grows. If the target hits any of the missle's height it counts as hit.
  void fireMissile(BuildContext context) {
    if (!midShot) {
      if (missileCount <= 2) {
        missileCount++;
      } else if (reloadCount <= 1) {
        showReloadDialog(context, this);
        reloadCount++;
        return;
      } else {
        showRestartDialog(context, this);
        return;
      }

      // Set missile position to player's position before firing
      missileX = playerX;
      missileY = 1;

      Timer.periodic(Duration(milliseconds: 20), (timer) {
        midShot = true;
        missileY -= 0.01; // Move missile up

        notifyListeners();

        // Stop missile when it reaches the top
        if (missileY < -1) {
          resetMissile();
          timer.cancel();
        }

        // Check collision with Bird 1
        if (bird1Active &&
            (missileY - bird1Y).abs() < 0.05 &&
            (bird1X - missileX).abs() < 0.1) {
          bird1Hits++;
          resetMissile();

          if (bird1Hits >= 2) {
            // Disable after two hits
            bird1Active = false;
            bird1X = 2; // Move bird off screen aka dissapear
          } else {
            // Randomize position and direction after hit
            bird1X = _random.nextDouble() * 2 - 1;
            bird1Y = _random.nextDouble() * 2 - 1;
            bird1Direction =
                _random.nextBool() ? Direction.left : Direction.right;
          }
          timer.cancel();
        }

        // Check collision with Bird 2
        if (bird2Active &&
            (missileY - bird2Y).abs() < 0.05 &&
            (bird2X - missileX).abs() < 0.1) {
          bird2Hits++;
          resetMissile();

          if (bird2Hits >= 2) {
            // Disable after two hits
            bird2Active = false;
            bird2X = 2; // Move bird off screen aka dissapear
          } else {
            // Randomize position and direction after hit
            bird2X = _random.nextDouble() * 2 - 1;
            bird2Y = _random.nextDouble() * 2 - 1;
            bird2Direction =
                _random.nextBool() ? Direction.left : Direction.right;
          }
          timer.cancel();
        }

        // Check if both birds have been hit twice within two reloads
        if (!bird1Active && !bird2Active) {
          levelUp(context);
        }
      });
    }
  }

  @override
  void levelUp(BuildContext context) {
    level++;
    showLevelUpDialog(context, this);
    notifyListeners();
  }

  @override
  void completeLevel(BuildContext context, String selectedCharacter) {
    // Transition to Level 2
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) => GameScreen3(
              gameState: GameState3(selectedCharacter: selectedCharacter, selectedMissile: selectedMissile),
              selectedCharacter: selectedCharacter,
            ),
      ),
    );
  }

  @override
  void restartGame() {
    restartGame();
    bird1X = _random.nextDouble() * 2 - 1;
    bird1Y = _random.nextDouble() * 2 - 1;
    bird1Direction = _random.nextBool() ? Direction.left : Direction.right;
    bird1Active = true;

    bird2X = _random.nextDouble() * 2 - 1;
    bird2Y = _random.nextDouble() * 2 - 1;
    bird2Direction = _random.nextBool() ? Direction.left : Direction.right;
    bird2Active = true;

    bird1Hits = 0;
    bird2Hits = 0;
  }

  @override
  void restartWholeGame(BuildContext context) {
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  bool get showCountdown => _showCountdown;
  int get countdown => _countdown;
}
