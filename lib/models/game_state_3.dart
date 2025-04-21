import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:shooting_game/models/game_state.dart';
import '../widgets/ui/game_dialogs.dart';
import '../utils/position_helper.dart';
import '../screens/choose_fairy.dart';

// A page containing the functionality behind the playable game system

class GameState3 extends GameState {
  StreamSubscription? _subscription;
  final String selectedCharacter;

  Random _random = Random(); // Random generator for spawn direction
  bool gameEnded = false;
  int playerHits = 0; //Track touching between player and bird

  BuildContext? currentContext;

  GameState3({required this.selectedCharacter, required String selectedMissile})
      : super(level: 3) {
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
  // Listener for a phone shake that will reset the missile counter and remove the info screen
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

  void checkCollision(BuildContext context) {
    if ((birdX - playerX).abs() < 0.1 && (birdY - playerY).abs() < 0.15) {
      gameEnded = true;
      showDeadDialog(context, this);
    }
  }

  @override
  // Target moving algorithm that allows the target to move left and right. The movement depends on the target hitting a wall.
  void startGame(BuildContext context) {
    currentContext = context; //store context to use it later
    double time = 0;
    double height = 0;
    double velocity = 90;
    playerY = 1;

    // Randomly set bird position
    birdX = _random.nextDouble() * 2 - 1; // Random position between -1 and 1
    birdY = _random.nextDouble() * 2 - 1; // Random position between -1 and 1
    birdDirection =
        _random.nextBool()
            ? Direction.right
            : Direction.left; // Random starting direction

    Timer.periodic(Duration(milliseconds: 20), (timer) {
      if (gameEnded) {
        timer.cancel();
        return;
      }

      height = -5 * time * time + velocity * time;

      if (height < 0) {
        time = 0;
      }

      birdY = heightToPosition(height, context);
      notifyListeners();

      if (birdX - 0.005 < -1) {
        birdDirection = Direction.right;
      } else if (birdX + 0.005 > 1) {
        birdDirection = Direction.left;
      }

      if (birdDirection == Direction.left) {
        birdX -= 0.005;
      } else if (birdDirection == Direction.right) {
        birdX += 0.005;
      }

      checkCollision(context);

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
  // Adding a new missile to the position of the character
  void resetMissile() {
    missileX = playerX;
    missileY = 1;
    midShot = false;
    notifyListeners();
  }

  @override
  // Resetting the missile fired count after phone shake
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
  // Firing the missile on button click. The missile consists of a pole that grows. If the target hits any of the missile's height it counts as hit.
  void fireMissile(BuildContext context) {
    if (!midShot) {
      if (missileCount <= 2) {
        missileCount++;
      } else if (reloadCount <= 2) {
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

        // Check for collision with bird
        if ((missileY - birdY).abs() < 0.1 && (birdX - missileX).abs() < 0.15) {
          hits++;
          resetMissile();
          birdX = _random.nextDouble() * 2 - 1;
          birdY = _random.nextDouble() * 2 - 1;
          birdDirection = _random.nextBool() ? Direction.right : Direction.left;
          timer.cancel();

          if (hits >= 2) {
            birdX = 10;
            gameEnded = true;
            levelUp(context);
            timer.cancel();
          }
        }
      });
    }
  }

  @override
  void levelUp(BuildContext context) {
    showGameOverDialog(context, this);
    notifyListeners();
  }

  @override
  void completeLevel(BuildContext context, String selectedCharacter) {
    Placeholder();
  }

  @override
  void restartGame() {
    gameEnded = false;
    playerX = 0;
    playerY = 1;
    missileX = 0;
    missileY = 1;
    missileCount = 0;
    midShot = false;
    birdX = _random.nextDouble() * 2 - 1;
    birdY = _random.nextDouble() * 2 - 1;
    birdDirection = _random.nextBool() ? Direction.right : Direction.left;
    reloadCount = 0;
    hits = 0;
    playerHits = 0;
    level = 3;
    resets = 0;
    notifyListeners();

    if (currentContext != null) {
      startGame(currentContext!);
    }
  }

  @override
  void restartWholeGame(BuildContext context) {
    gameEnded = false;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => ChooseFairy()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  bool get showCountdown => _showCountdown;
  int get countdown => _countdown;
}
