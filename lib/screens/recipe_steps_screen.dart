import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homebrew_dripper/models/coffee_recipe.dart';
import 'package:homebrew_dripper/models/recipe_step.dart';
import 'package:homebrew_dripper/screens/done_screen.dart';

class RecipeStepsScreen extends StatefulWidget {
  CoffeeRecipe recipe;

  RecipeStepsScreen(this.recipe);

  @override
  _RecipeStepsScreenState createState() => _RecipeStepsScreenState();
}

class _RecipeStepsScreenState extends State<RecipeStepsScreen> {
  int currentStep;
  List<RecipeStep> remainingSteps;
  int stepTimeRemaining;
  Timer timer;

  @override
  void initState() {
    super.initState();

    int totalSteps = widget.recipe.steps.length;

    currentStep = 0;
    remainingSteps = widget.recipe.steps;

    //set the starting value of the timer
    stepTimeRemaining = widget.recipe.steps[currentStep].time;

    //make timer that ticks every one seconds
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // if timer reached zero
      if (stepTimeRemaining < 1) {
        //increase step
        currentStep++;

        //if we finished
        if (currentStep >= totalSteps) {
          //cancel timer
          timer.cancel();

          //navigate to done screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DoneScreen()),
          );
        } else {
          //if we did not finish yet
          //adjust the timer
          //reduce the list of remaining steps
          stepTimeRemaining = widget.recipe.steps[currentStep].time;
          remainingSteps = widget.recipe.steps.sublist(currentStep);
          setState(() {});
        }
      } else {
        //adjust time remaining by one
        stepTimeRemaining = stepTimeRemaining - 1;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    RecipeStep currentRecipeStep = widget.recipe.steps[currentStep];

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Recipe Steps"),
      // ),
      backgroundColor: Color(0xFF4C748B),
      body: ListView(
        children: [
          SizedBox(height: 35),
          Text("$stepTimeRemaining",
              key: Key("step-time-remaining-text"),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 96, fontFamily: 'Kollektif')),
          SizedBox(height: 35),
          Text("${currentRecipeStep.text}",
              key: Key("current-step-text"),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 24, fontFamily: 'Kollektif')),
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("Steps",
                key: Key("steps-header-text"),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Kollektif')),
          ),
          SizedBox(height: 5),
          SizedBox(
            width: 100,
            height: 50,
            child: Card(
                elevation: 0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2,
                    color: Colors.white,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: ListTile(
                    title: Row(
                  children: [
                    Text(
                      currentRecipeStep.text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Kollektif'),
                      key: Key(
                          'step-${widget.recipe.steps.indexOf(currentRecipeStep)}-text'),
                    ),
                    Spacer(),
                    Text(
                      Duration(seconds: currentRecipeStep.time)
                          .toString()
                          .substring(2, 7),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Kollektif'),
                      key: Key(
                          'step-${widget.recipe.steps.indexOf(currentRecipeStep)}-time'),
                    ),
                  ],
                ))),
          ),
          for (RecipeStep step in remainingSteps)
            if (step != currentRecipeStep)
              ListTile(
                  title: Row(
                children: [
                  Text(
                    step.text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Kollektif'),
                    key: Key('step-${widget.recipe.steps.indexOf(step)}-text'),
                  ),
                  Spacer(),
                  Text(
                    Duration(seconds: step.time).toString().substring(2, 7),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Kollektif'),
                    key: Key('step-${widget.recipe.steps.indexOf(step)}-time'),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
