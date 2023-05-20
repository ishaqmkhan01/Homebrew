class RecipeStep {
  String text;
  int time;

  RecipeStep(text, time) {
    //add any rules to reject invalid values
    //for example, reject negative time
    if(text == null || time == null){
      throw ArgumentError();
    }
    else if(text == ""){
      throw ArgumentError();
    }
    else if(time <= 0){
      throw ArgumentError();
    }
    else{
    this.text = text;
    this.time = time;
    }
  }
}
