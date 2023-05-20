import 'package:homebrew_dripper/models/coffee_recipe.dart';
import 'package:homebrew_dripper/models/recipe_step.dart';

CoffeeRecipe makeSweetMariasRecipe() {
  List<RecipeStep> steps = [
    RecipeStep("Add 360g water", 30),
    RecipeStep("Cover and wait", 90),
    RecipeStep("Stir", 15),
    RecipeStep("Cover and wait", 75),
    RecipeStep("Stir", 15),
  ];
  CoffeeRecipe recipe = CoffeeRecipe(
      "Sweet Maria's",
      22,
      360,
      "finely ground coffee",
      "The original recipe: makes one delicious cup",
      steps);
  return recipe;
}

//link: https://www.ptscoffee.com/pages/pts-clever-dripper-brew-guide
CoffeeRecipe makePtsRecipe() {
  List<RecipeStep> steps = [
    RecipeStep("Add 50g water", 5),
    RecipeStep("Allow coffee to bloom", 30),
    RecipeStep("Pour 400g of water", 5),
    RecipeStep("Cover and wait", 120),
    RecipeStep("Gently lift the brewer and place it on top of the decanter", 225),
    RecipeStep("Give the decanter a swirl to aerate the coffee", 5),
  ];
  CoffeeRecipe recipe = CoffeeRecipe(
      "PT's",
      25,
      450,
      "medium-coarse ground coffee",
      "The original recipe: uses a burr grinder, whole bean specialty coffee, and #4 filters",
      steps);
  return recipe;
}

//link: https://texascoffeeschool.com/how-to-brew-better-tasting-clever-dripper-coffee-at-home-or-in-a-coffee-shop/
CoffeeRecipe makeTexasCoffeeSchoolRecipe() {
  List<RecipeStep> steps = [
    RecipeStep("Add 100g water", 5),
    RecipeStep("Allow coffee to bloom", 30),
    RecipeStep("Pour 240g of water", 5),
    RecipeStep("Cover and wait", 155),
    RecipeStep("Stir", 5),
    RecipeStep("Place your Clever atop your mug to begin the draw down process", 95),
  ];
  CoffeeRecipe recipe = CoffeeRecipe(
      "Texas Coffee School",
      24,
      340,
      "coarse ground coffee",
      "The original recipe: uses a burr grinder and #4 filters",
      steps);
  return recipe;
}

//link: https://www.homegrounds.co/clever-dripper-recipe
CoffeeRecipe makeHomegroundsRecipe() {
  List<RecipeStep> steps = [
    RecipeStep("Add 50g water", 5),
    RecipeStep("Allow coffee to bloom", 30),
    RecipeStep("Pour 295g of water", 5),
    RecipeStep("Cover and wait", 120),
    RecipeStep("Stir", 5),
    RecipeStep("Place your Clever atop your mug to begin the draw down process", 75),
  ];
  CoffeeRecipe recipe = CoffeeRecipe(
      "Homeground's",
      23,
      345,
      "medium-coarse ground coffee",
      "The original recipe: uses a burr grinder and freshly roasted coffee beans",
      steps);
  return recipe;
}

CoffeeRecipe makeTestRecipe() {
  List<RecipeStep> steps = [
    RecipeStep("Add 360g water", 5),
    RecipeStep("Cover and wait", 5),
    RecipeStep("Stir", 5),
    RecipeStep("Cover and wait", 5),
    RecipeStep("Stir", 5),
  ];
  CoffeeRecipe recipe = CoffeeRecipe(
      "Test Recipe",
      22,
      360,
      "finely ground coffee",
      "The original recipe: makes one delicious cup",
      steps);
  return recipe;
}

List<CoffeeRecipe> getAllRecipes() {
  return [makeSweetMariasRecipe(), makePtsRecipe(), makeTexasCoffeeSchoolRecipe(), makeHomegroundsRecipe(), makeTestRecipe()];
}

class CoffeeData {
  static List<CoffeeRecipe> loadRecipes() {
    return getAllRecipes();
  }
}
