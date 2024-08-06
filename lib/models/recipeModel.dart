import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class RecipeModel {
  final String id;
  final String name;
  final List<dynamic> ingredients;
  final List<dynamic> steps;
  final Map<String, dynamic> nutrition;
  final int time;
  final bool isNonVeg;
  String? categoryId;
  String category;
  // final double proteins; // Assuming proteins are stored as a double
  // final double calories; // Changed to double for fractional values
  // final String image;
  // final String quantityType;
  RecipeModel(
      {required this.id,
      required this.name,
      required this.nutrition,
      required this.time,
      required this.ingredients,
      required this.steps,
      required this.isNonVeg,
      required this.category,
      this.categoryId});

  // Factory method to create a RecipeModel from a JSON map
  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    String generateRandomId() {
      final now = DateTime.now();
      final timestamp = now.millisecondsSinceEpoch;
      final randomPart =
          (now.microsecondsSinceEpoch % 10000).toString().padLeft(4, '0');
      return '$timestamp$randomPart';
    }

    String? categoryId1 = null;
    if (json.containsKey('categoryId')) {
      categoryId1 = json['categoryId'];
    }

    
    return RecipeModel(
      id: generateRandomId(),
      name: json['name'] as String,
      ingredients: json['ingredients'],
      nutrition: json['nutrition'],
      isNonVeg: json['isNonVeg'] as bool,
      steps: json['steps'],
      time: int.parse(json['time'].toString()),
      category: json['category'],
      categoryId: categoryId1,
    );
  }

  // Method to convert RecipeModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "ingredients": ingredients,
      "nutrition": nutrition,
      "isNonVeg": isNonVeg,
      "steps": steps,
      "time": time,
      'category': category,
      'categoryId':categoryId ?? null,
    };
  }
}
