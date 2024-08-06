import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_eats/providers/categoryProvider.dart';
import 'package:gym_eats/providers/initialDataProvider.dart';
import 'package:gym_eats/providers/recipeProvider.dart';
import 'package:gym_eats/screens/basketPage.dart';
import 'package:gym_eats/screens/itemSearchPage.dart';
import 'package:gym_eats/screens/recipePage.dart';
import 'package:gym_eats/widgets/categories.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 223, 206, 204),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 20.0, left: 15),
      //   child: FloatingActionButton(
      //       onPressed: () {
      //         Navigator.push(
      //             context,
      //             PageTransition(
      //                 type: PageTransitionType.fade, child: BasketPage()));
      //       },
      //       // mini
      //       elevation: 5,
      //       backgroundColor: Colors.white,
      //       // backgroundColor: Colors.orange,
      //       child:
      //           //   Consumer<ItemBagProvider>(builder: (context, cartProvider, child) {
      //           // return
      //           GestureDetector(
      //               onTap: () {},
      //               child: Stack(
      //                 alignment: Alignment.topRight,
      //                 children: [
      //                   Icon(Icons.rice_bowl,
      //                       size: 30, color: Color.fromARGB(255, 254, 70, 70)),
      //                   CircleAvatar(
      //                     backgroundColor: Colors.white,
      //                     radius: 8,
      //                     // decoration: BoxDecoration(
      //                     //     color: Colors.red,
      //                     //     borderRadius: BorderRadius.circular(50)),
      //                     child: Padding(
      //                       padding: const EdgeInsets.all(3.0),
      //                       child: Text((10 > 99) ? "99+" : 10.toString(),
      //                           style: TextStyle(
      //                               color: Color.fromARGB(255, 254, 70, 70),
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: (10 > 99) ? 3 : 7)),
      //                     ),
      //                   )
      //                 ],
      //               ))),
      // ),
      // floatingActionButtonLocation:FloatingActionButtonLocation.miniStartFloat,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 20.0),
          //   child: Container(
          //     width: 40.0, // Set the width of the container
          //     height: 40.0, // Set the height of the container to make it square
          //     decoration: BoxDecoration(
          //       color: Color.fromARGB(255, 254, 70, 70),
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0), // Adjust padding as needed
          //       child: Center(
          //         child: Icon(
          //           Icons.notifications,
          //           color: Colors.white,
          //           size: 24.0, // Set icon size
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: BasketPage()));
              },
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 254, 70, 70),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                    padding:
                        const EdgeInsets.all(8.0), // Adjust padding as needed
                    child: Center(
                        child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Icon(Icons.shopping_bag_rounded,
                            size: 20, color: Colors.white),
                        // CircleAvatar(
                        //   backgroundColor:Color.fromARGB(255, 254, 70, 70),
                        //   radius: 8,
                        //   // decoration: BoxDecoration(
                        //   //     color: Colors.red,
                        //   //     borderRadius: BorderRadius.circular(50)),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(3.0),
                        //     child: Text((10 > 99) ? "99+" : 10.toString(),
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: (10 > 99) ? 3 : 7)),
                        //   ),
                        // )
                      ],
                    ))),
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "Gym",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20)),
          TextSpan(
              text: "Eats",
              style: TextStyle(
                  color: Colors.red[300],
                  fontWeight: FontWeight.w500,
                  fontSize: 20))
        ])),
      ),
      body: SafeArea(child:
          Consumer2<InitialDataProvider, SelectedCategoryProvider>(builder:
              (context, initialDataProvider, selectedCategoryProvider, child) {
        if ((initialDataProvider.isInitialDataLoaded == false) &&
            (initialDataProvider.isSearching == false)) {
          print("INITIALIZING DATA");
          print(initialDataProvider.isInitialDataLoaded);
          print(initialDataProvider.isSearching);
          initialDataProvider.setIsSearching(true);
          print(initialDataProvider.isSearching);
          initialDataProvider.getInitialData();
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: ItemSearchPage()));
                    // Navigator.push(context,MaterialPageRoute(builder: (context) => ItemSearchPage()));
                  },
                  child: Container(
                      child: Row(
                    children: [
                      Expanded(
                          child: Card(
                        elevation: 2,
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            enabled: false, // Icon inside TextField
                            hintText: 'Create recipe...',
                            hintStyle: TextStyle(
                                color: Colors.grey[600]), // Style for hint text
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Rounded corners for the border
                              borderSide: BorderSide
                                  .none, // Removes the default border side color
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Rounded corners for the enabled border
                              borderSide: BorderSide
                                  .none, // Removes the default border side color
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Rounded corners for the focused border
                              borderSide: BorderSide
                                  .none, // Removes the default border side color
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            filled:
                                true, // Makes the background color of TextField visible
                            fillColor: Colors.white, // Background color
                          ),
                        ),
                      )),

                      SizedBox(
                          width: 8.0), // Space between TextField and button
                      // elevation: 4.0, // Elevation for the button
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
                              weight: 2,
                            ), // Color for the icon
                            onPressed: () {
                              // Define the action for the button
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
                CategoriesList(),
                selectedCategoryProvider.selectedCategories.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "You may also like",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "Recipe's",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                selectedCategoryProvider.selectedCategories.isNotEmpty
                    ? (selectedCategoryProvider.isSearchingCategoryData
                        ? Column(
                            children: [1, 2, 3, 4, 5, 6, 6].map(
                            (category) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  child: Container(
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
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: Text(
                                            "Loading ...",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 254, 70, 70),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          subtitle: Wrap(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                                spacing: 8.0,
                                                        children: [
                                                          Container(
                                                            color: Colors.white,
                                                            height: 12,
                                                            width: 100,
                                                          ),
                                                          Container(
                                                            color: Colors.white,
                                                            height: 12,
                                                            width: 50,
                                                          ),
                                                          // Container(
                                                          //   color: Colors.white,
                                                          //   height: 12,
                                                          //   width: 100,
                                                          // ),
                                                // Text("Fats : ${recipe.nutrition['fats']}",style: TextStyle(color: Colors.grey,fontSize: 14),),
                                                // Text("Carbohydrates : ${recipe.nutrition['carbohydrate']}",style: TextStyle(color: Colors.grey,fontSize: 14),),
                                              ]),
                                          trailing: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromARGB(
                                                  255, 254, 70, 70),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 6),
                                            ),
                                            child: Text(
                                              "View",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            },
                          ).toList()
                            // ),
                            )
                        :selectedCategoryProvider
                                .selectedCategoriesData.isEmpty ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)
                                    ,color:Colors.white),
                                  child: Center(child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text("Nothing to display"),
                                  ))) : Column(
                            children: selectedCategoryProvider
                                .selectedCategoriesData
                                .map((recipe) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  child: Container(
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
                                      padding: const EdgeInsets.all(10.0),
                                      child: ListTile(
                                        title: Text(
                                          "${recipe.name}",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 254, 70, 70),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        subtitle: Wrap(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Proteins : ${recipe.nutrition['protein']} g",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                " | ",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                "Calories : ${recipe.nutrition['calories']} kcal",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                              // Text("Fats : ${recipe.nutrition['fats']}",style: TextStyle(color: Colors.grey,fontSize: 14),),
                                              // Text("Carbohydrates : ${recipe.nutrition['carbohydrate']}",style: TextStyle(color: Colors.grey,fontSize: 14),),
                                            ]),
                                        trailing: ElevatedButton(
                                          onPressed: () {
                                            RecipeProvider recipeProvider =
                                                Provider.of<RecipeProvider>(
                                                    context,
                                                    listen: false);
                                            recipeProvider.setRecipe(recipe);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType.fade,
                                                    child: RecipePage()));
                                            // Define the action for the button
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Color.fromARGB(255, 254, 70, 70),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 6),
                                          ),
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            }).toList(),
                          ))
                    : Container(),
                selectedCategoryProvider.selectedCategories.isNotEmpty
                    ? Container()
                    : (initialDataProvider.isSearching)
                        ? Column(
                            children:
                                initialDataProvider.getInitialRecipeList.map(
                            (category) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  child: Container(
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
                                            Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                width: screenWidht * 0.3,
                                                height: screenWidht * 0.3,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Container(
                                                    color: Colors.grey[300],
                                                    // Placeholder for image
                                                  ),
                                                ),
                                              ),
                                            ),
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
                                                  SizedBox(
                                                      height:
                                                          screenWidht * 0.04),
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
                          ).toList()
                            // ),
                            )
                        : Column(
                            children: initialDataProvider.getInitialRecipeList.isEmpty ? [Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)
                                    ,color:Colors.white),
                                  child: Center(child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text("Nothing to display"),
                                  )))] : initialDataProvider.getInitialRecipeList
                                .map((recipe) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  child: Container(
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
                                      padding: const EdgeInsets.all(10.0),
                                      child: ListTile(
                                        title: Text(
                                          "${recipe.name}",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 254, 70, 70),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        subtitle: Wrap(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Proteins : ${recipe.nutrition['protein']} g",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                " | ",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                "Calories : ${recipe.nutrition['calories']} kcal",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                              // Text("Fats : ${recipe.nutrition['fats']}",style: TextStyle(color: Colors.grey,fontSize: 14),),
                                              // Text("Carbohydrates : ${recipe.nutrition['carbohydrate']}",style: TextStyle(color: Colors.grey,fontSize: 14),),
                                            ]),
                                        trailing: ElevatedButton(
                                          onPressed: () {
                                            RecipeProvider recipeProvider =
                                                Provider.of<RecipeProvider>(
                                                    context,
                                                    listen: false);
                                            recipeProvider.setRecipe(recipe);
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType.fade,
                                                    child: RecipePage()));
                                            // Define the action for the button
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Color.fromARGB(255, 254, 70, 70),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 6),
                                          ),
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                              // Padding(
                              //   padding: const EdgeInsets.all(15.0),
                              //   child: Row(
                              //     crossAxisAlignment:
                              //         CrossAxisAlignment.start,
                              //     children: [
                              //       // Image Container
                              //       Container(
                              //         width: MediaQuery.of(context)
                              //                 .size
                              //                 .width *
                              //             0.3,
                              //         height: MediaQuery.of(context)
                              //                 .size
                              //                 .width *
                              //             0.3,
                              //         child: ClipRRect(
                              //           borderRadius:
                              //               BorderRadius.circular(15),
                              //           child: Image.network(
                              //             "https://static.toiimg.com/photo/108036977.cms",
                              //             fit: BoxFit.cover,
                              //           ),
                              //         ),
                              //       ),
                              //       SizedBox(width: 12.0),
                              //       // Information Column
                              //       Expanded(
                              //         child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             Text(
                              //               "Banana",
                              //               style: TextStyle(
                              //                 color: Color.fromARGB(
                              //                     255, 244, 67, 54),
                              //                 fontWeight: FontWeight.bold,
                              //                 fontSize: 18,
                              //               ),
                              //             ),
                              //             SizedBox(height: 4.0),
                              //             Wrap(children: [
                              //               Text(
                              //                 "Calories: 89",
                              //                 style: TextStyle(
                              //                   color: Colors.black87,
                              //                   fontSize: 12,
                              //                 ),
                              //               ),
                              //               SizedBox(
                              //                 width: 5,
                              //               ),
                              //               Text(
                              //                 "Protein: 1.1g",
                              //                 style: TextStyle(
                              //                   color: Colors.black87,
                              //                   fontSize: 12,
                              //                 ),
                              //               ),
                              //             ]),

                              //             SizedBox(
                              //                 height: screenWidht * 0.04),
                              //             // Add to Cart Button
                              //             Align(
                              //               alignment: AlignmentDirectional
                              //                   .bottomEnd,
                              // child: ElevatedButton(
                              //   onPressed: () {
                              //     // Define the action for the button
                              //   },
                              //   style:
                              //       ElevatedButton.styleFrom(
                              //     backgroundColor:
                              //         Color.fromARGB(
                              //             255, 254, 70, 70),
                              //     shape:
                              //         RoundedRectangleBorder(
                              //       borderRadius:
                              //           BorderRadius.circular(
                              //               10),
                              //     ),
                              //     padding:
                              //         EdgeInsets.symmetric(
                              //             horizontal: 8,
                              //             vertical: 6),
                              //   ),
                              //   child: Text(
                              //     "View",
                              //     style: TextStyle(
                              //         fontSize: 12,
                              //         color: Colors.white),
                              //   ),
                              // ),
                              // ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              //   ),
                              // ),
                              // );
                            }).toList(),
                          ),
              ],
            ),
          ),
        );
      })),
    );
  }
}
