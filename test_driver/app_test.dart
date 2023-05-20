// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:homebrew_dripper/models/coffee_recipe.dart';
import 'package:homebrew_dripper/utils/coffee_data.dart';
import 'package:test/test.dart';


void main() {
  // First, define the Finders and use them to locate widgets from the
  // test suite. Note: the Strings provided to the `byValueKey` method must
  // be the same as the Strings we used for the Keys in step 1.
  final coffeeRecipesTextFinder = find.byValueKey('coffee-recipes-text');
  final resourcesTextFinder = find.byValueKey('resources-text');
  final recipeNameTextFinder = find.byValueKey('recipe-name-text');
  final backBtnFinder = find.byValueKey('back-button');
  final recipeCoffeeTextFinder = find.byValueKey('recipe-coffee-text');
  final recipeWaterTextFinder = find.byValueKey('recipe-water-text');
  final recipeMiscTextFinder = find.byValueKey('recipe-misc-text');
  final recipeTotalTimeTextFinder = find.byValueKey('total-time-text');
  final startTextFinder = find.byValueKey('start-text');
  final startBtnFinder = find.byValueKey('start-button');
  final stepsHeaderTextFinder = find.byValueKey('steps-header-text');
  final currentStepText = find.byValueKey('current-step-text');
  final doneMsgTextFinder = find.byValueKey('done-msg-text');
  final doneTextFinder = find.byValueKey('done-text');
  final doneBtnFinder = find.byValueKey('done-button');

  List<CoffeeRecipe> recipes = CoffeeData.loadRecipes();
  var recipeInUse = recipes.last;
  int lastRecipeIndex = recipes.length - 1;
  var recipeSteps = recipeInUse.steps;

  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  group('Homebrew Dripper App', () {
    test('on start up, should be on recpie selection screen', () async {
      //should be able to see Coffee Recipes and Resources
      expect(await driver.getText(coffeeRecipesTextFinder), "Coffee Recipes");
      expect(await driver.getText(resourcesTextFinder), "Resources");

    });
    test('should be able to tap recipe and be taken to respective details screen', () async {
      expect(await driver.getText(getRecipeTextFinderAtIndex(lastRecipeIndex)), recipeInUse.name);
      await driver.tap(getRecipeBtnFinderAtIndex(lastRecipeIndex));
      expect(await driver.getText(recipeNameTextFinder), recipeInUse.name);
    });
    test('should be able to tap back button and be taken to back to recipe selection screen', () async {
      await driver.tap(backBtnFinder);
      expect(await driver.getText(coffeeRecipesTextFinder), 'Coffee Recipes');
      expect(await driver.getText(getRecipeTextFinderAtIndex(lastRecipeIndex)), recipeInUse.name);
      await driver.tap(getRecipeBtnFinderAtIndex(lastRecipeIndex));
      expect(await driver.getText(recipeNameTextFinder), recipeInUse.name);
    });
    test('should see Recipe name, details and steps', () async {
      expect(await driver.getText(recipeNameTextFinder), recipeInUse.name);
      expect(await driver.getText(recipeCoffeeTextFinder),
      '${recipeInUse.coffeeVolumeGrams}g - ${recipeInUse.grindSize}');
      expect(await driver.getText(recipeWaterTextFinder),
      '${recipeInUse.waterVolumeGrams}g - water');
      expect(await driver.getText(recipeMiscTextFinder), recipeInUse.miscDetails);
      expect(await driver.getText(recipeTotalTimeTextFinder), 'Total: ${recipeStepsTotalTime(recipeInUse)}');
      //checking all steps are present
      for(int i = 0; i < recipeSteps.length; i++){
        var currentStep = recipeSteps[i];
        expect(await driver.getText(getStepTextFinderAtIndex(i)), currentStep.text);
        expect(await driver.getText(getStepTimeFinderAtIndex(i)), formatTime(currentStep.time));
      }
    });
    test('should be able to tap start and be taken to steps screen', () async {
      expect(await driver.getText(startTextFinder),'Start');
      await driver.tap(startBtnFinder);
      expect(await driver.getText(stepsHeaderTextFinder), 'Steps');
    });

    //loop through all steps in the recipe in use to make
    //sure they are all present before they start dissappearing
    for(int i = 0; i < recipeSteps.length; i++){
      var currentStepTxt = recipeSteps[i].text;
      var currentStepTime = formatTime(recipeSteps[i].time);
      test('Step $i: "$currentStepTxt"', () async {
          expect(await driver.getText(getStepTextFinderAtIndex(i)), currentStepTxt);
      });
      test('Step $i: $currentStepTime', () async {
          expect(await driver.getText(getStepTimeFinderAtIndex(i)), currentStepTime);
      });
    }

    //loop through all tests to check that the Current Step is changing properly over time
    for(int i = 0; i < recipeSteps.length; i++){
      var currentStep = recipeSteps[i];
      String currentStepTxt = currentStep.text;
      int currentStepTime = currentStep.time;
      test('The Current Step should be step $i: "$currentStepTxt"', () async {
        expect(await driver.getText(currentStepText), currentStepTxt);
        //wait for the time allotted by the current step
        await Future.delayed(Duration(seconds: currentStepTime + 1), (){});
      });
    }
    test('Once the last step has ended, should be redirected to done screen', () async {
      expect(await driver.getText(doneMsgTextFinder), 'enjoy your amazing\nhandmade coffee');
    });
    test('The done button should redirect back to the recipe selection screen', () async {
      expect(await driver.getText(doneTextFinder), 'done');
      await driver.tap(doneBtnFinder);
      expect(await driver.getText(coffeeRecipesTextFinder), "Coffee Recipes");
    });
  });
}

getRecipeTextFinderAtIndex(int i){
  return find.byValueKey('recipe-$i-text');
}

getRecipeBtnFinderAtIndex(int i){
  return find.byValueKey('recipe-$i-button');
}

getStepTextFinderAtIndex(int i){
  return find.byValueKey('step-$i-text');
}

getStepTimeFinderAtIndex(int i){
  return find.byValueKey('step-$i-time');
}

String formatTime(int seconds){
  return Duration(seconds: seconds).toString().substring(2,7);
}

String recipeStepsTotalTime(recipe) {
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