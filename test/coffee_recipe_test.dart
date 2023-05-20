import 'package:homebrew_dripper/models/coffee_recipe.dart';
import 'package:homebrew_dripper/models/recipe_step.dart';
import 'package:test/test.dart';

void main() {
  test('creates a valid coffee recipe', () {
    //make a coffee recipe
    List<RecipeStep> steps = [
      RecipeStep("Add 360g water", 5),
      RecipeStep("Cover and wait", 5),
      RecipeStep("Stir", 5),
      RecipeStep("Cover and wait", 5),
      RecipeStep("Stir", 5),
    ];
    CoffeeRecipe recipe = CoffeeRecipe(
      "testRecipe",
      22,
      360,
      "grindSize",
      "miscDetails",
      steps
    );
    //check that it has the right data
    expect(recipe.name, "testRecipe");
    expect(recipe.coffeeVolumeGrams, 22);
    expect(recipe.waterVolumeGrams, 360);
    expect(recipe.grindSize, "grindSize");
    expect(recipe.miscDetails, "miscDetails");
    expect(recipe.steps, steps);
  });

  //how do we test rejecting invalid coffee recipes?
  test('creates an invalid coffee recipe', () {
    //make a coffee recipe
    List<RecipeStep> nullSteps;
    List<RecipeStep> emptySteps = [];
    List<RecipeStep> steps = [
      RecipeStep("Add 360g water", 5),
    ];
    
    expect(
      () => CoffeeRecipe(
        null,
        22,
        360,
        "grindSize",
        "miscDetails",
        steps
      ), throwsArgumentError);

    expect(
      () => CoffeeRecipe(
        "",
        22,
        360,
        "grindSize",
        "miscDetails",
        steps
      ), throwsArgumentError);
    expect(

      () => CoffeeRecipe(
        "testRecipe",
        0,
        360,
        "grindSize",
        "miscDetails",
        steps
      ), throwsArgumentError);
    
    expect(
      () => CoffeeRecipe(
        "testRecipe",
        -1,
        360,
        "grindSize",
        "miscDetails",
        steps
      ), throwsArgumentError);
    
    expect(
      () => CoffeeRecipe(
        "testRecipe",
        22,
        0,
        "grindSize",
        "miscDetails",
        steps
      ), throwsArgumentError);

    expect(
      () => CoffeeRecipe(
        "testRecipe",
        22,
        -1,
        "grindSize",
        "miscDetails",
        steps
      ), throwsArgumentError);

    expect(
      () => CoffeeRecipe(
        "testRecipe",
        22,
        360,
        null,
        "miscDetails",
        steps
      ), throwsArgumentError);

    expect(
      () => CoffeeRecipe(
        "testRecipe",
        22,
        360,
        "",
        "miscDetails",
        steps
      ), throwsArgumentError);

    expect(
      () => CoffeeRecipe(
        "testRecipe",
        22,
        360,
        "grindSize",
        null,
        steps
      ), throwsArgumentError);

    expect(
      () => CoffeeRecipe(
        "testRecipe",
        22,
        360,
        "grindSize",
        "",
        steps
      ), throwsArgumentError);

    expect(
      () => CoffeeRecipe(
        "testRecipe",
        22,
        360,
        "grindSize",
        "miscDetails",
        nullSteps
      ), throwsArgumentError);

    expect(
      () => CoffeeRecipe(
        "testRecipe",
        22,
        360,
        "grindSize",
        "miscDetails",
        emptySteps
      ), throwsArgumentError);
  });
}
