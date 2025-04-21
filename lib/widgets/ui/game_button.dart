import 'package:flutter/material.dart';

// Page consisting of the code behind how the buttons look like 

class GameButton extends StatelessWidget {
  final String imageB;
  final VoidCallback function;

  const GameButton({super.key, required this.imageB, required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 90,
          height: 90,
          child: Center(child: Image.asset(imageB)),
        ),
      ),
    );
  }
} 