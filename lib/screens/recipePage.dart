import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_eats/models/recipeModel.dart';
import 'package:gym_eats/providers/recipeProvider.dart';
import 'package:provider/provider.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  String convertSecondsToMinutes(seconds) {
    if (seconds.runtimeType == String) {
      int? secInInt = int.tryParse(seconds);
      if (secInInt == null) {
        return "Not Available";
      } else {
        int minutes = (secInInt / 60).toInt();
        return "${minutes}";
      }
    }
    if (seconds != 0) {
      int minutes = (seconds / 60).toInt();
      return "${minutes}";
    } else {
      return "Not Available";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.transparent,
          title: Text("Recipe Details"),
        ),
      body: SafeArea(
        child: Consumer<RecipeProvider>(
          builder: (context, recipeProvider, child) {
            RecipeModel? recipe = recipeProvider.getGeneratedRecipe;

            if (recipe == null) {
              return Center(child: Text("No Recipe Data Available"));
            }
            List<dynamic> steps = recipe.steps;
            // if (recipe.containsKey('instructions')) {
            //   steps = recipe['instructions'];
            // } else if (recipe.containsKey('steps')) {
            //   steps = recipe['steps'];
            // } else if (recipe.containsKey('step')) {
            //   steps = recipe['step'];
            // } else if (recipe.containsKey('process')) {
            //   steps = recipe['process'];
            // } else if (recipe.containsKey('procedure')) {
            //   steps = recipe['procedure'];
            // }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recipe Title
                    // Text(recipe.toString()),
                    Center(
                      child: Container(
                        child: Text(
                          recipe.name ?? 'Recipe Name',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Wrap(
                        runAlignment: WrapAlignment.center,alignment: WrapAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_alarms_rounded,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text.rich(TextSpan(
                              text: recipe.time.toString(),
                              children: [TextSpan(text: " Minutes")])),
                              Text(" | ",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                              Icon(recipe.isNonVeg ? Icons.restaurant:  Icons.local_florist,
                            color:recipe.isNonVeg? Colors.red : Colors.green
                            ),
                                                      SizedBox(
                            width: 5,
                          ),
                            Text(
                              recipe.isNonVeg ? "Non Veg" : "Veg",
                              style: TextStyle(
                                color:recipe.isNonVeg? Colors.red : Colors.green
                              ),
                            ),Text(" | ",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            Text(
                              recipe.category,
                              style: TextStyle(
                                color:Colors.black
                              )),
                        ],
                      ),
                    ),
                    // SizedBox(height: 10),
                    //   Center(
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                            
                    //       ],
                    //     ),
                    //   ),
                    SizedBox(height: 20),

                    // Ingredients Section
                    _buildSectionTitle("Ingredients"),
                    _buildIngredientsList(recipe.ingredients),
                    SizedBox(height: 20),

                    // Instructions Section
                    _buildSectionTitle("Steps"),
                    _buildInstructionsList(steps),
                    SizedBox(height: 20),

                    // Nutritional Information Section
                    _buildSectionTitle("Nutritional Information"),
                    _buildNutritionalInfo(recipe.nutrition),
                    ListTile(
                      title: Text(
                        'Note: Nutritional values are approximate and may vary.',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 254, 70, 70),
        ),
      ),
    );
  }

  Widget _buildIngredientsList(List<dynamic>? ingredients) {
    if (ingredients == null || ingredients.isEmpty) {
      return Center(child: Text("No Ingredients Available"));
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: ingredients.map((ingredient) {
            return ListTile(
              tileColor: Colors.white,
              // contentPadding: EdgeInsets.all(16),
              // leading: Icon(Icons.food_bank, color: Colors.deepOrangeAccent),
              title: Text(
                ingredient['name'],
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: Text(
                ingredient['quantity'],
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              // subtitle: Text('${ingredient['quantity']} ${ingredient['unit']}'),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildInstructionsList(List<dynamic>? instructions) {
    if (instructions == null || instructions.isEmpty) {
      return Center(child: Text("No Instructions Available"));
    }
    int counter = 0;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Column(
          children: instructions.map((instruction) {
            counter++;
            return ListTile(
              tileColor: Colors.white,
              // contentPadding: EdgeInsets.all(16),
              leading: Text(
                "${counter}.",
                style: TextStyle(color: Color.fromARGB(255, 254, 70, 70)),
              ),
              title: Text(
                instruction,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNutritionalInfo(Map<String, dynamic> recipe) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 16.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            _buildNutritionItem(Icons.local_fire_department, 'Calories',
                '${(recipe['calories'] ?? recipe['calorie']) ?? "Not Available"} kcal'),
            _buildNutritionItem(
                Icons.local_dining, 'Protein', '${(recipe['protein'] ?? recipe['proteins']) ?? "Not Available"} g'),
            _buildNutritionItem(Icons.grain_rounded, 'Carbohydrates',
                '${(recipe['carbohydrates'] ?? recipe['carbohydrate']) ??"Not Available"} g'),
            _buildNutritionItem(
                Icons.water_drop, 'Fats', '${(recipe['fats'] ?? recipe['fat']) ?? "Not Available"} g'),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionItem(IconData icon, String label, String value) {
    return ListTile(
      leading: CircleAvatar(
        radius: 15,
        backgroundColor: Color.fromARGB(255, 254, 70, 70),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
      title: Text(label, style: TextStyle(fontSize: 16)),
      trailing: Text(value, style: TextStyle(fontSize: 16)),
    );
  }
}
