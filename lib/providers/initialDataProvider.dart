import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_eats/models/categoriesModel.dart';
import 'package:gym_eats/models/recipeModel.dart';
import 'package:gym_eats/services/recipeServices.dart';

class InitialDataProvider extends ChangeNotifier {
  String _textQuery = "";
  bool _isOnlyVeg = false;
  bool _isSearching = false;
  bool _isInitialDataLoaded = false;
  List<CategoriesModel> _categoriesList = [];
  List<RecipeModel> _initialRecipes = [];
  String get textQuery => _textQuery;
  List<CategoriesModel> get getCategoriesList => _categoriesList;
  List<RecipeModel> get getInitialRecipeList => _initialRecipes;
  bool get isInitialDataLoaded => _isInitialDataLoaded;
  bool get onlyVeg => _isOnlyVeg;
  bool get isSearching => _isSearching;

  setTextQuery(String query) {
    _textQuery = query;
    notifyListeners();
  }

  setIsOnlyVeg(bool value) {
    _isOnlyVeg = value;
    notifyListeners();
  }

  setIsSearching(bool value) {
    _isSearching = value;
    print("SET ISSEARCHING TO TRUE");
    notifyListeners();
  }

  setIsInitialDataLoaded(bool value) {
    _isInitialDataLoaded = value;
    notifyListeners();
  }

  Future<void> getInitialData() async {
    // await Future.delayed(Duration(seconds: 3));
    final _firebaseInstance = FirebaseFirestore.instance;
    try {
      QuerySnapshot querySnapshot =
          await _firebaseInstance.collection('categories').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var data in querySnapshot.docs) {
          Map<String, dynamic> dataInMap = data.data() as Map<String, dynamic>;
          print(dataInMap);
          _categoriesList.add(CategoriesModel.fromJson(dataInMap));
        }
      }
    } catch (e) {
      print(e);
    }
    // _categoriesList = ['Veg', 'Egg', 'Fish', 'Fruits', "argrgaerhaehrehh"];
    _initialRecipes = await RecipeServices().fetchRecipes();
    _isSearching = false;
    _isInitialDataLoaded = true;
    notifyListeners();
  }
}
