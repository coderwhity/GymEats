import 'package:flutter/material.dart';
import 'package:gym_eats/models/basketItemModel.dart';
import 'package:gym_eats/providers/basketProvider.dart';
import 'package:gym_eats/providers/recipeProvider.dart';
import 'package:gym_eats/screens/recipePage.dart';
import 'package:gym_eats/services/gemini-services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});
  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Basket"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Consumer<BasketProvider>(
                    builder: (context, basketProvider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          basketProvider.itemsInBasket.isNotEmpty ? Text(
                            "Items",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ) :Container(),
                          SizedBox(height: 10),
                          basketProvider.itemsInBasket.isEmpty ? SingleChildScrollView(
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.10,
                        ),
                        Image.asset(
                          'assets/empty-cart.png',
                          width: screenWidth * 0.46,
                        ),
                        Text(
                          "Good Food is Always Cooking",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        Text(
                          "Your basket is empty. Add something from the items.",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )),
                ) : Column(
                            children:  basketProvider.itemsInBasket.map((item) {
                              TextEditingController textEditingController =
                                  TextEditingController(
                                      text: item.quantity.toString());
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 244, 67, 54),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              "Calories: ${item.calories}g",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 12,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Protein: ${item.proteins}g",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: item.quantityType ==
                                                  'incremental'
                                              ? [
                                                  GestureDetector(
                                                      onTap: () {
                                                        print("REMOVE ITEM");
                                                        basketProvider
                                                            .removeItem(
                                                                item.id);
                                                      },
                                                      child:
                                                          Icon(Icons.remove)),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    item.quantity.toString(),
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 254, 70, 70),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        print("ADD ITEM");
                                                        basketProvider.addItem(
                                                            BasketItemModel(
                                                                id: item.id,
                                                                name: item.name,
                                                                isNonVeg: item
                                                                    .isNonVeg,
                                                                proteins: item
                                                                    .proteins,
                                                                calories: item
                                                                    .calories,
                                                                image:
                                                                    item.image,
                                                                quantity: 1,
                                                                quantityType: item
                                                                    .quantityType));
                                                      },
                                                      child: Icon(Icons.add))
                                                ]
                                              : [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 30,
                                                    child: TextField(
                                                      textAlign:
                                                          TextAlign.center,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5),
                                                      ),
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 254, 70, 70),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      controller:
                                                          textEditingController,
                                                      onSubmitted: (value) {
                                                        if (textEditingController
                                                                    .text
                                                                    .trim()
                                                                    .length ==
                                                                0 ||
                                                            textEditingController
                                                                .text.isEmpty ||
                                                            double.parse(
                                                                    textEditingController
                                                                        .text) <=
                                                                0) {
                                                          basketProvider
                                                              .removeItemTextQuantity(
                                                                  item!);
                                                          return;
                                                        }
                                                        basketProvider
                                                            .addItemTextQuantity(
                                                                item!,
                                                                textEditingController
                                                                    .text);
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  GestureDetector(
                                                    onTap: () {
                                                      print("CONFIRM ITEM");
                                                      if (textEditingController
                                                                  .text
                                                                  .trim()
                                                                  .length ==
                                                              0 ||
                                                          textEditingController
                                                              .text.isEmpty ||
                                                          double.parse(
                                                                  textEditingController
                                                                      .text) <=
                                                              0) {
                                                        basketProvider
                                                            .removeItemTextQuantity(
                                                                item!);
                                                        return;
                                                      }
                                                      basketProvider
                                                          .addItemTextQuantity(
                                                              item!,
                                                              textEditingController
                                                                  .text);
                                                    },
                                                    child: Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          basketProvider.itemsInBasket.isNotEmpty? ListTile(
                            title: Text(
                              'Nutrient values are shown per 100 grams of the food item.',
                              style: TextStyle(fontSize: 10),
                            ),
                          ) :Container() ,
                        ],
                      );
                    },
                  ),
                ),
              ),
               Consumer<RecipeProvider>(
                  builder: (context, recipeProvider, child) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Container(
                    width: screenWidth,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Define the action for the button
                        print("Submit action");
                        BasketProvider basketProvider =
                            Provider.of<BasketProvider>(context, listen: false);
                        List<Map<String, dynamic>> listOfItemsMap =
                            basketProvider.itemsInBasket.map((value) {
                          return value.toGeminDataJson();
                        }).toList();
                        print(listOfItemsMap);
                        if (listOfItemsMap.length >= 1) {
                          print("ITEMS IN LIST");
                          // RecipeProvider recipeProvider =
                          //     Provider.of<RecipeProvider>(context, listen: false);
                          print(recipeProvider.getIsGeneratingRecipe);
                          if (recipeProvider.getIsGeneratingRecipe) {
                            print("ALREADY GENERATING");
                            return;
                          }
                          recipeProvider.setErrorOccured(false);
                          recipeProvider.setIsGeneratingRecipe(true);
                          await recipeProvider.generateRecipe(listOfItemsMap);
                          if (recipeProvider.getGeneratedRecipe == null) {
                            print("SOMETHING WENT WRONG");
                          } else {
                            print("TILL HERE TO REDIRECT");
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: RecipePage()));
                          }

                          // Map<String, dynamic>? recipe = await GeminiServices.generateRecipe(listOfItemsMap);
                          // print(recipe);
                          // Map<String, dynamic>? recipe = {
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
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 254, 70, 70),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: recipeProvider.getIsGeneratingRecipe
                          ? LoadingAnimationWidget.fourRotatingDots(
                              color: Colors.white,
                              size: 24,
                            )
                          : Text(
                              "Generate Recipe",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
