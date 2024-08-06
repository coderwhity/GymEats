import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_eats/models/recipeModel.dart';

class RecipeServices {
  DocumentSnapshot? _lastDocument;
  DocumentSnapshot? _lastCategoryDocument;
  bool _hasMoreData = true;
  bool get hasMoreData => _hasMoreData;

  Future<void> storeRecipe(RecipeModel? recipe) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    if (recipe == null) return; // Check for null recipe

    try {
      // Check if a recipe with the same name already exists
      QuerySnapshot querySnapshot = await _firestore
          .collection('recipes')
          .where('name', isEqualTo: recipe.name)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print('Recipe already exists, no need to update.');
        return;
      }

      // Fetch the category ID from the 'categories' collection
      if (recipe.category != null) {
        QuerySnapshot categoryQuerySnapshot = await _firestore
            .collection('categories')
            .where('title', isEqualTo: recipe.category)
            .get();

        if (categoryQuerySnapshot.docs.isNotEmpty) {
          // Assuming the category name is unique, get the first match
          var catData =
              categoryQuerySnapshot.docs.first.data() as Map<String, dynamic>;
          String categoryId = catData['id'];
          recipe.categoryId = categoryId;
        } else {
          recipe.categoryId = "other";
          recipe.category = "Other's";
        }
      }

      // Store the recipe in the 'recipes' collection
      await _firestore
          .collection('recipes')
          .doc(recipe.id)
          .set(recipe.toJson());
      print('Recipe stored successfully');
    } catch (e) {
      print('Error storing recipe: $e');
    }
  }

  Future<List<RecipeModel>> fetchRecipes({int limit = 10}) async {
    List<RecipeModel> recipes = [];

    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      Query query =
          _firestore.collection('recipes').orderBy('name').limit(limit);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        _lastDocument = querySnapshot.docs.last;
        _hasMoreData = querySnapshot.docs.length == limit; // Check if more data is available
        recipes = querySnapshot.docs
            .map((doc) =>
                RecipeModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      } else {
        _hasMoreData = false; // No more data available
      }
    } catch (e) {
      print('Error fetching recipes: $e');
    }

    return recipes;
  }

  Future<List<RecipeModel>> fetchRecipesByCategoryIds(
      List<String> categoryIds, {int limit = 10}) async {
    List<RecipeModel> recipes = [];

    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      Query query = _firestore
          .collection('recipes')
          .where('categoryId', whereIn: categoryIds)
          .orderBy('name')
          .limit(limit);

      if (_lastCategoryDocument != null) {
        query = query.startAfterDocument(_lastCategoryDocument!);
      }

      QuerySnapshot querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        _lastCategoryDocument = querySnapshot.docs.last;
        _hasMoreData = querySnapshot.docs.length == limit; // Check if more data is available
        recipes = querySnapshot.docs
            .map((doc) =>
                RecipeModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      } else {
        _hasMoreData = false; // No more data available
      }
    } catch (e) {
      print('Error fetching recipes by category: $e');
    }

    return recipes;
  }

  void resetPagination() {
    _lastDocument = null;
    _lastCategoryDocument = null;
    _hasMoreData = true;
  }
}
