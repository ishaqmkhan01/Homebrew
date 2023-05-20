import 'package:flutter/material.dart';
import 'package:homebrew_dripper/screens/recipe_selection_screen.dart';

class DoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Done"),
        // ),
        body: Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 300),
            child: Text(
              "enjoy your amazing\nhandmade coffee",
              key: Key('done-msg-text'),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF4C748B),
                  fontFamily: 'Montserrat',
                  fontSize: 18),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  key: Key('done-button'),
                  onPressed: () => {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecipeSelectionScreen()),
                          (Route<dynamic> route) => false,
                        )
                      },
                  child: Text(
                    "done",
                    key: Key('done-text'),
                    style: TextStyle(
                        color: Color(0xFF4C748B),
                        fontFamily: 'Montserrat',
                        fontSize: 18),
                  )),
            ),
          )
        ],
      ),
    ));
  }
}
