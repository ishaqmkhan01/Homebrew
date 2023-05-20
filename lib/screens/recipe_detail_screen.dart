import 'package:flutter/material.dart';
import 'package:homebrew_dripper/models/coffee_recipe.dart';
import 'package:homebrew_dripper/screens/recipe_steps_screen.dart';
import 'package:homebrew_dripper/models/recipe_step.dart';

class RecipeDetailScreen extends StatelessWidget {
  CoffeeRecipe recipe;
  RecipeDetailScreen(this.recipe);

  //Get total time of recipe steps
  String recipeStepsTotalTime() {
    int totalSteps = recipe.steps.length;
    int currentStep = 0;
    int stepTimesAdded = 0;

    int minutes = 0;
    int seconds = 0;

    //Total time before conversion
    while (currentStep < totalSteps) {
      stepTimesAdded += recipe.steps[currentStep].time;
      currentStep++;
    }

    //Get minutes
    while (stepTimesAdded > 60) {
      stepTimesAdded -= 60;
      minutes++;
    }

    //Get seconds
    seconds = stepTimesAdded;

    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              key: Key("back-button"),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Color(0xFF4C748B))),
          //title: Text("Recipe Details"),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: ListView(
        children: [
          SizedBox(
            width: 100,
            height: 150,
            child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0xFF4c748b),
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Text(
                      recipe.name,
                      key: Key('recipe-name-text'),
                      style: TextStyle(
                          color: Color(0xFF4c748b),
                          fontFamily: 'Kollektif',
                          fontSize: 18),
                    ),
                    SizedBox(height: 1),
                    const Divider(
                      height: 20,
                      thickness: 1,
                      indent: 1,
                      endIndent: 0,
                      color: Color(0xFF4c748b),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "${recipe.coffeeVolumeGrams}g - ${recipe.grindSize}",
                      key: Key('recipe-coffee-text'),
                      style: TextStyle(
                          color: Color(0xFF4c748b),
                          fontFamily: 'Kollektif',
                          fontSize: 14),
                    ),
                    Text(
                      "${recipe.waterVolumeGrams}g - water",
                      key: Key('recipe-water-text'),
                      style: TextStyle(
                          color: Color(0xFF4c748b),
                          fontFamily: 'Kollektif',
                          fontSize: 14),
                    ),
                    SizedBox(height: 23),
                    Text(
                      "${recipe.miscDetails}",
                      key: Key('recipe-misc-text'),
                      style: TextStyle(
                          color: Color(0xFF4c748b),
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.italic,
                          fontSize: 10),
                    ),
                  ],
                )),
          ),
          SizedBox(height: 18),
          //Steps
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Steps",
                  style: TextStyle(
                      color: Color(0xFF4c748b),
                      fontFamily: 'Kollektif',
                      fontSize: 14),
                ),
              ),
              Spacer(),
              Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    "Total: ${recipeStepsTotalTime()}",
                    key: Key('total-time-text'),
                    style: TextStyle(color: Color(0xFF4c748b)),
                  )),
            ],
          ),
          for (RecipeStep step in recipe.steps)
            SizedBox(
              width: 100,
              height: 50,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2,
                    color: Color(0xFF4c748b),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: ListTile(
                    title: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: Text(
                      step.text,
                      style: TextStyle(
                          color: Color(0xFF4c748b),
                          fontFamily: 'Kollektif',
                          fontSize: 12),
                      key: Key('step-${recipe.steps.indexOf(step)}-text'),
                    ),),
                    
                    Spacer(),
                    Text(
                      Duration(seconds: step.time).toString().substring(2, 7),
                      style: TextStyle(
                          color: Color(0xFF4c748b),
                          fontFamily: 'Kollektif',
                          fontSize: 12),
                      key: Key('step-${recipe.steps.indexOf(step)}-time'),
                    ),
                  ],
                )),
              ),
            ),
          SizedBox(height: 50),
          SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                key: Key('start-button'),
                style: ElevatedButton.styleFrom(
                  //minimumSize: Size(20, 40),
                  primary: Color(0xFF4c748b),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
                child: Text(
                  "Start",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 14),
                  key: Key('start-text'),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecipeStepsScreen(recipe)),
                  );
                },
              ))
        ],
      ),
    );
  }
}
