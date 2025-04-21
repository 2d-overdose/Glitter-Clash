import 'package:flutter/material.dart';
import '../screens/choose_fairy.dart';

//A welcome page with a scart button that brings you to a page to choose your character

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // The container takes full width
        height: double.infinity, // The container takes full height
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/rules.png"), // Background image
            fit: BoxFit.cover, // The image covers the entire area
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'RULES AND LEVELS',
              style: TextStyle(
                fontFamily: 'Jersey',
                color: Color(0xFFDD5B75),
                fontSize: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                '''Level 1:
- Hit the evil head 3 times within the allowed reloads. 
- You have 3 spells each reload.
- You have two reloads. 

Level 2: 
- Hit each evil head 2 times within the allowed reloads. 
- You have 3 spells each reload.
- You have two reloads. 

Level 3: 
- Hit the evil witch Espera 2 times within the allowed reloads. 
- You have 3 spells each reload.
- You have two reloads. 
- Avoid touching Espera at all costs, she will defeat you otherwise. 
              ''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Jersey',
                  color: Color(0xFFDD5B75),
                  fontSize: 20,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter, // Centeres the button
              child: TextButton(
                child: Text(
                  "<< Continue >>",
                  style: TextStyle(
                    fontFamily: 'Jersey',
                    color: Color(0xFFDD5B75),
                    fontSize: 35,
                  ),
                ),
                onPressed: () {
                  // Navigate to the choosing a fairy page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChooseFairy()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
