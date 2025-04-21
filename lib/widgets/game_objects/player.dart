import 'package:flutter/material.dart';

// Page consisting of the code behind how the player looks like

class MyPlayer extends StatelessWidget {
  final double playerX;
  final double playerY;
  final String characterImage;
  const MyPlayer({
    super.key,
    required this.playerX,
    required this.playerY,
    required this.characterImage,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        alignment: Alignment(playerX, playerY),
        child: Image.asset(
          characterImage, // Use the selected character
          height: 180,
          width: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
