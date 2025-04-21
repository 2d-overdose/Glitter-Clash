import 'package:flutter/material.dart';

// Page consisting of the code behind how the missle counter signifier looks like

class MyMissileCounter extends StatelessWidget {
  final int missileCount;
  final int level;
  const MyMissileCounter({super.key, required this.missileCount, required this.level});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Putting the missile counter and the actual count under one another for better readability 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 65),
              Text(
                "Used spell count:",
                style: TextStyle(
                  fontFamily: 'Jersey',
                  color: Colors.white,
                  fontSize: 25,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                "< $missileCount >",
                style: TextStyle(
                  fontFamily: 'Jersey',
                  color: Color(0xFFDD5B75),
                  fontSize: 30,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          SizedBox(width: 150,), // space between the missile and the level 
          // Putting the level label and the actual level under one another for better readability 
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 65),
              Text(
                "Level:",
                style: TextStyle(
                  fontFamily: 'Jersey',
                  color: Colors.white,
                  fontSize: 25,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                "< $level >",
                style: TextStyle(
                  fontFamily: 'Jersey',
                  color: Color(0xFFDD5B75),
                  fontSize: 30,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ],
    );
  }
}
