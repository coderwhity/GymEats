import 'package:flutter/material.dart';
import 'package:gym_eats/models/basketItemModel.dart';
import 'package:gym_eats/models/itemModel.dart';

class BasketProvider extends ChangeNotifier {
  double _totalProtein = 0;
  double _totalCalories = 0;
  List<BasketItemModel> _itemsInBasket = [];
  bool isGeneratingRecipe = false;

  List<BasketItemModel> get itemsInBasket => _itemsInBasket;
  void updateNutrientsTotal() {
    for (var item in _itemsInBasket) {
      _totalCalories += item.calories;
      _totalProtein += item.proteins;
    }
  }

  void addItem(BasketItemModel item) async {
    int index =
        _itemsInBasket.indexWhere((basketItem) => basketItem.id == item.id);

    if (index == -1) {
      _itemsInBasket.add(item);
    } else {
      _itemsInBasket[index].quantity += 1;
      print("TOTAL QUANTITY : ${_itemsInBasket[index].quantity}");
    }
    updateNutrientsTotal();
    notifyListeners();
  }

  void addItemTextQuantity(BasketItemModel item, String quantity) {
    print("REPLACING QUANTITY OF ${item.name} TO ${item.quantity}");
    int index =
        _itemsInBasket.indexWhere((basketItem) => basketItem.id == item.id);

    if (index == -1) {
      item.quantity = int.parse(quantity);
      _itemsInBasket.add(item);
    } else {
      item.quantity = int.parse(quantity);
      _itemsInBasket[index].quantity = int.parse(quantity);
      print(
          "TOTAL QUANTITY FOR FLUID SUBSTANCE : ${_itemsInBasket[index].quantity}");
    }
    updateNutrientsTotal();
    notifyListeners();
  }

  void removeItemTextQuantity(BasketItemModel item) {
    int index =
        _itemsInBasket.indexWhere((basketItem) => basketItem.id == item.id);

    if (index != -1) {
      _itemsInBasket.removeAt(index);
      // _itemsInBasket[index].quantity -= item.quantity;
    }
    updateNutrientsTotal();
    notifyListeners();
  }

  void removeItem(String id) async {
    int index = _itemsInBasket.indexWhere((basketItem) => basketItem.id == id);

    if (index != -1) {
      if (_itemsInBasket[index].quantity == 1) {
        _itemsInBasket.removeAt(index);
      } else {
        _itemsInBasket[index].quantity -= 1;
      }
    }
    updateNutrientsTotal();
    notifyListeners();
  }
}
