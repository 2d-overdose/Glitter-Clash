import 'dart:async';
import 'package:flutter/material.dart';

enum Direction { left, right }

abstract class GameState extends ChangeNotifier {
  StreamSubscription? _subscription;
  bool isPopupOpen = false;

  //player variable
  double playerX = 0;
  double playerY = 1;

  // missile variables
  double missileX = 0;
  double missileY = 1;
  int missileCount = 0;
  bool midShot = false;

  //target variables
  double birdX = 0.7;
  double birdY = 1;
  Direction birdDirection = Direction.left;

  //leve variables
  int reloadCount = 0;
  int hits = 0;
  int level;
  int resets = 0;

  String selectedMissile = 'assets/images/pink_missile.png';

  //countdown variables
  int _countdown = 3;
  bool _showCountdown = false;

  GameState({required this.level});

  void startCountdown(BuildContext context);
  void startGame(BuildContext context);
  void moveLeft();
  void moveRight();
  void fireMissile(BuildContext context);
  void resetMissile();
  void resetCounter(BuildContext context);
  void levelUp(BuildContext context);
  void completeLevel(BuildContext context, String selectedCharacter);
  void restartGame();
  void initShakeDetector(BuildContext context);
  void restartWholeGame(BuildContext context);

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  bool get showCountdown => _showCountdown;
  int get countdown => _countdown;

  void updateState() {
    notifyListeners();
  }
}
