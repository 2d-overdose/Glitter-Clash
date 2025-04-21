import 'package:flutter/material.dart';
import 'package:shooting_game/screens/rules_screen.dart';

//A welcome page with a scart button that brings you to a page to choose your character

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // The container takes full width
        height: double.infinity, // The container takes full height
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/welcome.png"), // Background image
            fit: BoxFit.cover, // The image covers the entire area
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 200), // Move the button lower
          child: Align(
            alignment: Alignment.bottomCenter, // Centeres the button
          child: IconButton(
            icon: Image.asset('assets/images/start_button.png'),
            iconSize: 50,
            onPressed: () {
              // Navigate to the choosing a fairy page 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RulesScreen()),
              );
            },
          ),
        ),
      ),
    ));
  }
}

