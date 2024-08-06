import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_eats/models/itemModel.dart';

class SearchProvider extends ChangeNotifier {
  String _textQuery = "";
  bool _isOnlyVeg = false;
  bool _isSearching = false;
  List<FoodItem> _searchedItems = [];

  String get textQuery => _textQuery;
  bool get onlyVeg => _isOnlyVeg;
  bool get isSearching => _isSearching;
  List<FoodItem> get searchedItems => _searchedItems;

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

  Future<List<FoodItem>> fetchFoodItems(String query) async {
    print("QUERY : ${query}");
    // Reference to the Firestore collection
    CollectionReference foodCollection =
        FirebaseFirestore.instance.collection('food_items');

    // Perform the query
    QuerySnapshot querySnapshot = await foodCollection
        .where('name', isGreaterThanOrEqualTo:  query[0].toUpperCase() + query.substring(1).toLowerCase())
        .where('name', isLessThanOrEqualTo: query[0].toUpperCase() + query.substring(1).toLowerCase() + '\uf8ff')
        .get();


    // Convert the results to a list of FoodItem objects
    List<FoodItem> foodItems = querySnapshot.docs.map((doc) {
      return FoodItem.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    return foodItems;
  }

  Future<void> searchItem(String value) async {
    _searchedItems.clear();
    // await Future.delayed(Duration(seconds: 1));

    _searchedItems = await fetchFoodItems(value);
    print("TOTAL ITEMS : ${_searchedItems.length}");
    _isSearching = false;
    notifyListeners();
  }
}
