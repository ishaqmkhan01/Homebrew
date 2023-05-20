import 'recipe_step.dart';

class CoffeeRecipe {
  String name;
  int coffeeVolumeGrams;
  String grindSize;
  int waterVolumeGrams;
  String miscDetails;
  List<RecipeStep> steps;

  CoffeeRecipe(name, coffeeVolumeGrams, waterVolumeGrams, grindSize,
      miscDetails, steps) {
    //add any rules to reject invalid values
    //for example, reject negative gram amounts
    if(name == null || name.isEmpty || coffeeVolumeGrams == null
      || waterVolumeGrams == null || grindSize == null || grindSize.isEmpty
      || miscDetails == null || miscDetails.isEmpty || steps == null){
        throw ArgumentError("did a thing");
    }
    if(coffeeVolumeGrams < 1 || waterVolumeGrams < 1){
      throw ArgumentError();
    }
    if(steps.length == 0){
      throw ArgumentError();
    }
    this.name = name;
    this.coffeeVolumeGrams = coffeeVolumeGrams;
    this.waterVolumeGrams = waterVolumeGrams;
    this.grindSize = grindSize;
    this.miscDetails = miscDetails;
    this.steps = steps;
  }
}
