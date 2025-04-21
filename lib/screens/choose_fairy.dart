import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/fairy_state.dart';

// Page that consists of the UI behind choosing a fairy. Buttons for back and next, choosing the caracter, character images and signifiers. 

class ChooseFairy extends StatelessWidget {
  const ChooseFairy({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FairyState(), // Provide FairyState
      child: Consumer<FairyState>(
        // Listen to changes in FairyState
        builder: (context, fairyState, _) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  // Background image 
                  image: AssetImage("assets/images/screen.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Image(
                      // Choose a fairy signifier 
                      image: AssetImage('assets/images/choose_fairy.png'),
                    ),
                  ),
                  Container(
                    height: 400, // Set height for the fairy view 
                    child: PageView.builder(
                      controller:
                          fairyState
                              .pageController, // Attach the controller to fairy view 
                      itemCount: fairyState.characterImages.length,
                      itemBuilder: (context, index) {
                        // Show the selection of fairy characters 
                        return Image.asset(fairyState.characterImages[index]);
                      },
                      onPageChanged:
                          fairyState
                              .onPageChanged, // Update the selected character when the page changes
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Button to view the previous character option 
                        TextButton(
                          onPressed:
                              fairyState
                                  .goToPreviousCharacter, // Navigate to the previous character
                          child: Text(
                            '<< Back',
                            style: TextStyle(
                              fontFamily: 'Jersey',
                              color: Color(0xFFDD5B75),
                              fontSize: 35,
                            ),
                          ),
                        ),
                        // Add some space between the buttons
                        SizedBox(
                          width: 100,
                        ),
                        // Button to view the next character option 
                        TextButton(
                          onPressed:
                              fairyState
                                  .goToNextCharacter, // Navigate to the next character
                          child: Text(
                            'Next >>',
                            style: TextStyle(
                              fontFamily: 'Jersey',
                              color: Color(0xFFDD5B75),
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Decoration image 
                  Image(image: AssetImage('assets/images/hearts.png')),
                  // Button to "lock in" the user's choice + forward to the playable game page 
                  TextButton(
                    onPressed: () => fairyState.goToNextPage(context),
                    child: Text(
                      "<< Let's play together >>",
                      style: TextStyle(
                        fontFamily: 'Jersey',
                        color: Color(0xFFDD5B75),
                        fontSize: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
