import 'package:flutter/material.dart';

// Page consisting of the code behind how the missile looks like 

class MyMissile extends StatelessWidget {
  final double missileX;
  final double missileY;
  final String missileImagePath;
  const MyMissile({super.key, required this.missileX, required this.missileY, required this.missileImagePath,});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(missileX, missileY),
      child: Container(
        width: 80, 
        height: 100, 
        decoration: BoxDecoration(
          color: Colors.transparent, 
        ),
        child: Image.asset(
          missileImagePath,
          key: ValueKey(missileImagePath),
      ),
    ),);
  }
} 