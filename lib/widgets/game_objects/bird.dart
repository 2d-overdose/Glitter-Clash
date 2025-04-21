import 'package:flutter/material.dart';

// Page consisting of the code behind how the target looks like 

class MyBird1 extends StatelessWidget {
  final double birdX;
  final double birdY;

  const MyBird1({super.key, required this.birdX, required this.birdY});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(birdX, birdY),
      child: Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/monster_head_1.png'),
          fit: BoxFit.fill,
        ),
      ),
    )
    );
  }
} 

class MyBird2 extends StatelessWidget {
  final double birdX;
  final double birdY;

  const MyBird2({super.key, required this.birdX, required this.birdY});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(birdX, birdY),
      child: Container(
      height: 50.0,
      width: 40.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/monster_head_2.png'),
          fit: BoxFit.fill,
        ),
      ),
    )
    );
  }
} 

class MyBird3 extends StatelessWidget {
  final double birdX;
  final double birdY;

  const MyBird3({super.key, required this.birdX, required this.birdY});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(birdX, birdY),
      child: Container(
      height: 80.0,
      width: 70.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/monster_head_3.png'),
          fit: BoxFit.contain,
        ),
      ),
    )
    );
  }
} 
class MyBird4 extends StatelessWidget {
  final double birdX;
  final double birdY;

  const MyBird4({super.key, required this.birdX, required this.birdY});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(birdX, birdY),
      child: Container(
      height: 140.0,
      width: 130.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/espera.png'),
          fit: BoxFit.contain,
        ),
      ),
    )
    );
  }
} 