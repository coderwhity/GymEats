import 'package:flutter/material.dart';
import 'package:gym_eats/models/categoriesModel.dart';
import 'package:gym_eats/models/recipeModel.dart';
import 'package:gym_eats/services/recipeServices.dart';

class SelectedCategoryProvider extends ChangeNotifier {
  String _textQuery = "";
  bool _isOnlyVeg = false;
  bool _isSearching = false;
  List<CategoriesModel> _selectedCategories = [];
  List<RecipeModel> _selectedCategoriesdata = [];
  Map<String, dynamic> _fetchedData = {};
  String get textQuery => _textQuery;
  bool get onlyVeg => _isOnlyVeg;
  bool get isSearchingCategoryData => _isSearching;
  List<CategoriesModel> get selectedCategories => _selectedCategories;
  List<RecipeModel> get selectedCategoriesData => _selectedCategoriesdata;

  setSelectedCategories(CategoriesModel query) {
    _selectedCategories.clear();
    // if (_selectedCategories.contains(query)) {
    //   return;
    // }
    _selectedCategories.add(query);
    notifyListeners();
  }

  removeSelectedCategories(CategoriesModel query) {
    if (_selectedCategories.contains(query)) {
      _selectedCategories.remove(query);
      notifyListeners();
    }
  }

  setIsOnlyVeg(bool value) {
    _isOnlyVeg = value;
    notifyListeners();
  }

  setIsSearchingCategoryData(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  Future<void> getCategoryData() async {
    print("GETTING CATEGORY DATA");
    List<Map<String, dynamic>> newList = [];
    // for (var element in _selectedCategories) {}
    if (_fetchedData.containsKey(_selectedCategories.firstOrNull)) {
      print("2SEC");
      // await Future.delayed(Duration(seconds: 2));
      _selectedCategoriesdata = _fetchedData[_selectedCategories.firstOrNull];
    } else {
      // await Future.delayed(Duration(seconds: 3));
      print("3SEC");
      // _selectedCategoriesdata = [
      //   'Veg',
      //   'Egg',
      //   'Fish',
      //   'Fruits',
      //   "argrgaerhaehrehh"
      // ];
      List<String> catIds = [];
      for (var cat in _selectedCategories) {
        catIds.add(cat.id);
      }
      _selectedCategoriesdata =
          await RecipeServices().fetchRecipesByCategoryIds(catIds);
      _fetchedData[_selectedCategories.first.id] = _selectedCategoriesdata;
    }
    _isSearching = false;
    notifyListeners();
  }
}
