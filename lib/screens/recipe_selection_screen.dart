import 'package:flutter/material.dart';
import 'package:homebrew_dripper/models/coffee_recipe.dart';
import 'package:homebrew_dripper/screens/recipe_detail_screen.dart';
import 'package:homebrew_dripper/utils/coffee_data.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RecipeSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Recipe Selection"),
      // ),
      body: ListView(
        children: [
          SizedBox(height: 30),
          Text(
            "Coffee Recipes",
            key: Key("coffee-recipes-text"),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4C748B),
              fontFamily: 'Kollektif',
            ),
          ),
          RecipeList(),
          SizedBox(height: 22),
          Text(
            "Resources",
            key: Key("resources-text"),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4C748B),
              fontFamily: 'Kollektif',
            ),
          ),
          SizedBox(height: 5),
          ResourceList()
        ],
      ),
    );
  }
}

class RecipeList extends StatelessWidget {
  List<CoffeeRecipe> recipes = CoffeeData.loadRecipes();

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: Color(0xFF4c748b),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            for (CoffeeRecipe recipe in recipes)
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide()),
                ),
                child: ListTile(
                    key: Key('recipe-${recipes.indexOf(recipe)}-button'),
                    title: Text(
                      recipe.name,
                      style: TextStyle(
                          color: Color(0xFF4C748B),
                          fontFamily: 'Montserrat',
                          fontSize: 14),
                      key: Key('recipe-${recipes.indexOf(recipe)}-text'),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Color(0xFF4c748b),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecipeDetailScreen(recipe)),
                      );
                    }),
              )
          ],
        ));
  }
}

class ResourceList extends StatelessWidget {
  //map for saving name of button and its link
  Map<String, String> resourceMap = {
    'Coffee': 'https://www.homegrounds.co/best-coffee-beans-bucket-list',
    'Grinders': 'https://www.seriouseats.com/the-best-coffee-grinders',
    'Kettles': 'https://www.tomsguide.com/best-picks/the-best-electric-kettles',
    'Homebrew Dripper': 'https://www.homegrounds.co/best-pour-over-coffee-makers/',
  };
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: Color(0xFF4c748b),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(children: [for(var resourceName in resourceMap.keys)
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide()),
              ),
              child: ListTile(
                title: Text(resourceName,
                    style: TextStyle(
                        color: Color(0xFF4C748B),
                        fontFamily: 'Montserrat',
                        fontSize: 14)),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Color(0xFF4c748b),
                ),
                onTap: () 
                {
                  canLaunchUrlString(resourceMap[resourceName]).then((canLaunch){
                    if(canLaunch){
                      launchUrlString(resourceMap[resourceName]);
                    }
                  });
                },
              ),
            ),
          ]));
  }
}
