import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_eats/models/basketItemModel.dart';
import 'package:gym_eats/models/itemModel.dart';
import 'package:gym_eats/providers/basketProvider.dart';
import 'package:gym_eats/providers/searchProvider.dart';
import 'package:gym_eats/screens/basketPage.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ItemSearchPage extends StatefulWidget {
  const ItemSearchPage({super.key});

  @override
  State<ItemSearchPage> createState() => _ItemSearchPageState();
}

class _ItemSearchPageState extends State<ItemSearchPage> {
  bool _isOnlyVeg = false;
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: Consumer<SearchProvider>(
            builder: (context, searchProvider, child) {
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25.0, right: 25, left: 25),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 2,
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.search, color: Colors.grey),
                                  hintText: 'Search Item...',
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 12.0),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Card(
                            elevation: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 254, 70, 70),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  if (_searchController.text.isEmpty) {
                                    return;
                                  }
                                  if (searchProvider.isSearching) {
                                    return;
                                  }
                                  searchProvider.setIsSearching(true);
                                  await searchProvider
                                      .searchItem(_searchController.text);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Text(
                  //         "Only Veg",
                  //         style: TextStyle(color: Colors.green),
                  //       ),
                  //       Switch(
                  //         activeColor: Colors.green,
                  //         value: _isOnlyVeg,
                  //         onChanged: (value) {
                  //           searchProvider.setIsOnlyVeg(value);
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 5),
                  (searchProvider.isSearching)
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Container(
                                      height: screenWidth * 0.3,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0,
                                                4), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Image Container
                                            // Shimmer.fromColors(
                                            //   baseColor: Colors.grey[300]!,
                                            //   highlightColor: Colors.grey[100]!,
                                            //   child: Container(
                                            //     width: screenWidth * 0.4,
                                            //     height: screenWidth * 0.4,
                                            //     child: ClipRRect(
                                            //       borderRadius:
                                            //           BorderRadius.circular(15),
                                            //       child: Container(
                                            //         color: Colors.grey[300],
                                            //         // Placeholder for image
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                            SizedBox(width: 12.0),
                                            // Information Column
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[100]!,
                                                    child: Container(
                                                      color: Colors.grey[300],
                                                      height: 20.0,
                                                      width: 120.0,
                                                    ),
                                                  ), // Placeholder for name text
                                                  SizedBox(height: 4.0),
                                                  Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[100]!,
                                                    child: Wrap(
                                                      spacing: 5.0,
                                                      children: [
                                                        // Container(
                                                        //   color: Colors.grey[300],
                                                        //   height: 16.0,
                                                        //   width: 80.0,
                                                        // ), // Placeholder for calories
                                                        Container(
                                                          color:
                                                              Colors.grey[300],
                                                          height: 16.0,
                                                          width: 80.0,
                                                        ), // Placeholder for protein
                                                      ],
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //     height:
                                                  //         screenWidth * 0.04),
                                                  // Add to Cart Button
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .bottomEnd,
                                                    child: Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[100]!,
                                                      child: Container(
                                                        color: Colors.grey[300],
                                                        height: 30.0,
                                                        width: 100.0,
                                                        child: Center(
                                                          child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            height: 20.0,
                                                            width: 60.0,
                                                          ), // Placeholder for button text
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )));
                            },
                          ),
                        )
                      : Consumer<BasketProvider>(
                          builder: (context, basketProvider, child) {
                          if (searchProvider.searchedItems.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text("Nothing item found..."),
                                    ))),
                              ),
                            );
                          }
                          return Expanded(
                            child: ListView.builder(
                              itemCount: searchProvider.searchedItems.length,
                              itemBuilder: (context, index) {
                                FoodItem item =
                                    searchProvider.searchedItems[index];
                                int indexInBasket = basketProvider.itemsInBasket
                                    .indexWhere((basketItem) =>
                                        basketItem.id == item.id);
                                BasketItemModel? itemFromBasket = null;
                                if (indexInBasket != -1) {
                                  itemFromBasket = basketProvider
                                      .itemsInBasket[indexInBasket];
                                }
                                TextEditingController textEditingController =
                                    TextEditingController(
                                        text: indexInBasket == -1
                                            ? 100.toString()
                                            : itemFromBasket!.quantity
                                                .toString());
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Container(
                                    // height: screenWidth * 0.5,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: Offset(0,
                                              4), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Image Container
                                          // Container(
                                          //   width: MediaQuery.of(context)
                                          //           .size
                                          //           .width *
                                          //       0.4,
                                          //   height: MediaQuery.of(context)
                                          //           .size
                                          //           .width *
                                          //       0.4,
                                          //   child: ClipRRect(
                                          //     borderRadius:
                                          //         BorderRadius.circular(15),
                                          //     child: Image.network(
                                          //       (item.image.trim().length == 0)
                                          //           ? "https://static.toiimg.com/photo/108036977.cms"
                                          //           : item.image,
                                          //       fit: BoxFit.cover,
                                          //     ),
                                          //   ),
                                          // ),
                                          // SizedBox(width: 12.0),
                                          // Information Column
                                          Expanded(
                                            child: Column(
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
                                                SizedBox(height: 4.0),
                                                Wrap(children: [
                                                  Text(
                                                    "Calories: ${item.calories}",
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "Protein: ${item.proteins}",
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ]),
                                                // Expanded(child: Container()),
                                                // SizedBox(
                                                //     height: screenWidth * 0.04),
                                                // Add to Cart Button
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .bottomEnd,
                                                  child: (indexInBasket == -1)
                                                      ? ElevatedButton(
                                                          onPressed: () {
                                                            // basketProvider.removeItem(item.id);
                                                            if (item.quantityType ==
                                                                'incremental') {
                                                              basketProvider.addItem(BasketItemModel(
                                                                  id: item.id,
                                                                  name:
                                                                      item.name,
                                                                  isNonVeg: item
                                                                      .isNonVeg,
                                                                  proteins: item
                                                                      .proteins,
                                                                  calories: item
                                                                      .calories,
                                                                  image: item
                                                                      .image,
                                                                  quantity: 1,
                                                                  quantityType:
                                                                      item.quantityType));
                                                            } else {
                                                              basketProvider.addItem(BasketItemModel(
                                                                  id: item.id,
                                                                  name:
                                                                      item.name,
                                                                  isNonVeg: item
                                                                      .isNonVeg,
                                                                  proteins: item
                                                                      .proteins,
                                                                  calories: item
                                                                      .calories,
                                                                  image: item
                                                                      .image,
                                                                  quantity: 100,
                                                                  quantityType:
                                                                      item.quantityType));
                                                            }
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    254,
                                                                    70,
                                                                    70),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        6),
                                                          ),
                                                          child: Text(
                                                            "Add to Basket",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    screenHeight *
                                                                        0.0120,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      : Align(
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .bottomEnd,
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children:
                                                                  item.quantityType ==
                                                                          'incremental'
                                                                      ? [
                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                print("REMOVE ITEM");
                                                                                basketProvider.removeItem(item.id);
                                                                              },
                                                                              child: Icon(Icons.remove)),
                                                                          SizedBox(
                                                                              width: 5),
                                                                          Text(
                                                                            basketProvider.itemsInBasket[indexInBasket].quantity.toString(),
                                                                            style: TextStyle(
                                                                                color: Color.fromARGB(255, 254, 70, 70),
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                print("ADD ITEM");
                                                                                basketProvider.addItem(BasketItemModel(id: item.id, name: item.name, isNonVeg: item.isNonVeg, proteins: item.proteins, calories: item.calories, image: item.image, quantity: 1, quantityType: item.quantityType));
                                                                              },
                                                                              child: Icon(Icons.add))
                                                                        ]
                                                                      : [
                                                                          SizedBox(
                                                                            width:
                                                                                50, // Adjust width as needed
                                                                            height:
                                                                                30, // Adjust height as needed
                                                                            child:
                                                                                TextField(
                                                                              textAlign: TextAlign.center,
                                                                              keyboardType: TextInputType.number,
                                                                              decoration: InputDecoration(
                                                                                
                                                                                border: OutlineInputBorder(),
                                                                                contentPadding: EdgeInsets.symmetric(horizontal: 5), // Adjust content padding if needed
                                                                              ),
                                                                              style: TextStyle(
                                                                                color: Color.fromARGB(255, 254, 70, 70),
                                                                                fontSize: 13,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                              controller: textEditingController,
                                                                              onSubmitted: (value) {
                                                                                if (textEditingController.text.trim().length == 0 || textEditingController.text.isEmpty || double.parse(textEditingController.text) <= 0) {
                                                                                  basketProvider.removeItemTextQuantity(itemFromBasket!);
                                                                                  return;
                                                                                }
                                                                                basketProvider.addItemTextQuantity(itemFromBasket!, textEditingController.text);
                                                                                // basketProvider.addItemTextQuantity(basketProvider.itemsInBasket[index]);
                                                                                // basketProvider.itemsInBasket[index].quantity.toString(),
                                                                                // basketProvider
                                                                                // Update quantity in provider
                                                                              },
                                                                            ),
                                                                          ),
                                                                          // Text(searchProvider.searchedItems[index].quantityType),
                                                                          SizedBox(
                                                                              width: 5),
                                                                          // Tick mark icon
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              print("CONFIRM ITEM");
                                                                              if (textEditingController.text.trim().length == 0 || textEditingController.text.isEmpty || double.parse(textEditingController.text) <= 0) {
                                                                                basketProvider.removeItemTextQuantity(itemFromBasket!);
                                                                                return;
                                                                              }
                                                                              basketProvider.addItemTextQuantity(itemFromBasket!, textEditingController.text);
                                                                              // Define the action for the tick mark icon
                                                                              // basketProvider.confirmItem(item.id);
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.check,
                                                                              color: Colors.green,
                                                                            ),
                                                                          ),
                                                                        ],
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
