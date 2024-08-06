import 'package:flutter/foundation.dart';
import 'package:gym_eats/models/recipeModel.dart';
import 'package:gym_eats/services/gemini-services.dart';
import 'package:gym_eats/services/recipeServices.dart';

class RecipeProvider extends ChangeNotifier {
  bool _isGeneratingRecipe = false;
  RecipeModel? _generatedRecipe = null;
  bool _errorOccured = false;

  bool get getIsGeneratingRecipe => _isGeneratingRecipe;
  bool get getErrorOccured => _errorOccured;
  RecipeModel? get getGeneratedRecipe => _generatedRecipe;

  void setIsGeneratingRecipe(bool value) {
    _isGeneratingRecipe = value;
    notifyListeners();
  }

  void setRecipe(RecipeModel recipe) {
    _generatedRecipe = recipe;
    notifyListeners();
  }

  void setErrorOccured(bool value) {
    _errorOccured = value;
    notifyListeners();
  }

  Future<void> generateRecipe(List<Map<String, dynamic>> itemsData) async {
    print("START");
    _generatedRecipe = await GeminiServices.generateRecipe(itemsData);
    if (_generatedRecipe != null) {
      try {
        print("Store Recipe to DB");
        await RecipeServices().storeRecipe(_generatedRecipe);
      } catch (e) {
        print(e);
      }
    }
    // _generatedRecipe = {
    //   "name": "Banana Milk Smoothie",
    //   "ingredients": [
    //     {"name": "Milk", "quantity": 100, "unit": "ml"}
    //   ],
    //   "instructions": [
    //     "Peel and slice the bananas.",
    //     "Pour the milk into a blender.",
    //     "Add the sliced bananas to the blender.",
    //     "Blend until smooth."
    //   ],
    //   "calories": 250,
    //   "protein": 5,
    //   "time": 60
    // };
    print("TILL HERE");
    if (_generatedRecipe == null) {
      _isGeneratingRecipe = false;
      notifyListeners();
      return;
    }
    _isGeneratingRecipe = false;
    notifyListeners();
  }
}
