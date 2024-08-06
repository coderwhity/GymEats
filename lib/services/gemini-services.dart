import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:gym_eats/models/recipeModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class GeminiServices {
  static Future<RecipeModel?> generateRecipe(
      List<Map<String, dynamic>> ingredients) async {
    try {

      final client = GenerativeModel(
          model: 'gemini-1.5-flash-latest',
          apiKey: dotenv.env['GEMINI_API_KEY'] ?? "");

      // Prepare the prompt for Gemini
      final promptString =
          'Generate a recipe for a dish using the following ingredients: ${jsonEncode(ingredients)}.\n return JSON {name:String,ingredients:[{name:String,quantity:String}],steps:[String],nutrition:{calories:int,fats,carbohydrate,protein},time:int(mins),isNonVeg:bool,category:String} of recipe easy and short.return JSON put recipe in one of this category [Protein-Packed,Pre-Workout,Post-Workout,Low-Carb,High-Energy,Meal Prep]';

      final response = await client.generateContent(
        [Content.text(promptString)],
      );
      if (response.text == null) {
        return null;
      }
      RecipeModel? extractedData = null;
      int startIndex = response.text!.indexOf('{');
      int endIndex = response.text!.lastIndexOf('}') + 1;

      if (startIndex != -1 && endIndex != -1 && startIndex < endIndex) {
        String jsonString = response.text!.substring(startIndex, endIndex);
        try {
          Map<String, dynamic> jsonData = jsonDecode(jsonString);
          print('Extracted JSON data: $jsonData');
          // VALIDATING RESPONSE
          if (jsonData.containsKey('name') &&
              jsonData.containsKey('ingredients') &&
              jsonData.containsKey('steps') &&
              jsonData.containsKey('nutrition') &&
              jsonData.containsKey('time') &&
              jsonData.containsKey('isNonVeg') &&
              jsonData.containsKey('category')) {
            extractedData = RecipeModel.fromJson(jsonData);
            // extractedData = jsonData;
          } else {
            return null;
          }
        } catch (e) {
          print('Error parsing JSON: $e');
          return null;
        }
      } else {
        print('No JSON found in the string.');
        return null;
      }
      return extractedData;
    } catch (e) {
      return null;
    }
  }
}
