import 'dart:math';

import 'package:homebrew_dripper/models/coffee_recipe.dart';
import 'package:homebrew_dripper/models/recipe_step.dart';
import 'package:test/test.dart';

void main() {
  test('creates a valid recipe step', () {
    //make a recipe step
    var step = RecipeStep("text", 5);
    //check that it has the right data
    expect(step.text, "text");
    expect(step.time, 5);
  });

  //how do we test rejecting invalid recipe steps?
  test('creates an invalid recipe step', () {
    expect(()=>RecipeStep(null, 1), throwsArgumentError);
    expect(()=>RecipeStep("text", null), throwsArgumentError);
    expect(()=>RecipeStep("", 1), throwsArgumentError);
    expect(()=>RecipeStep("text", 0), throwsArgumentError);
    expect(()=>RecipeStep("text", -1), throwsArgumentError);
  });
}
