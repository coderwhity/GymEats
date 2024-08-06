import 'package:flutter/material.dart';
import 'package:gym_eats/models/categoriesModel.dart';
import 'package:gym_eats/providers/categoryProvider.dart';
import 'package:gym_eats/providers/initialDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  bool hasRenderingIssue = false; // Flag for detecting rendering issues

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Consumer2<InitialDataProvider, SelectedCategoryProvider>(
      builder: (context, initialDataProvider, selectedCategoryProvider, child) {
        List<CategoriesModel> categories = initialDataProvider.getCategoriesList;
        List<CategoriesModel> selectedCategories = selectedCategoryProvider.selectedCategories;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            initialDataProvider.isSearching
                ? Container(
                    height: screenHeight * 0.14, // Fixed height for loading state
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: screenWidth * 0.16,
                              child: Column(
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: screenWidth * 0.16,
                                      height: screenWidth * 0.10, // Reduced height
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(15)),
                                      child: Center(
                                        child: Icon(Icons.image, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: screenWidth * 0.16,
                                      child: Text(
                                        "Loading...",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.03, // Font size relative to screen width
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    height: screenHeight * 0.14, // Fixed height for categories
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        bool isSelected = selectedCategories.contains(category);

                        // Measure the text to determine overflow
                        final textPainter = TextPainter(
                          text: TextSpan(
                            text: category.title,
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          textDirection: TextDirection.ltr,
                          maxLines: 2,
                          ellipsis: '...',
                        )..layout(maxWidth: screenWidth * 0.16);
                        
                        // Determine if the text overflows
                        bool textOverflows = textPainter.didExceedMaxLines;

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                          child: GestureDetector(
                            onTap: () {
                              if (selectedCategoryProvider.isSearchingCategoryData) {
                                return;
                              }
                              if (isSelected) {
                                selectedCategoryProvider.removeSelectedCategories(category);
                                return;
                              }
                              selectedCategoryProvider.setSelectedCategories(category);
                              selectedCategoryProvider.setIsSearchingCategoryData(true);
                              selectedCategoryProvider.getCategoryData();
                            },
                            child: Container(
                              width: screenWidth * 0.17, // Set width explicitly
                              decoration: BoxDecoration(
                                color: isSelected ? Color.fromARGB(255, 254, 70, 70) : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  if (isSelected)
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.5),
                                      blurRadius: 5,
                                      offset: Offset(0, 2),
                                    ),
                                ],
                              ),
                              padding: EdgeInsets.all(screenWidth * 0.01), // Adjusted padding
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: screenWidth * 0.16,
                                    height: screenWidth * 0.10, // Reduced height
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        category.image ?? "https://cdn-icons-png.flaticon.com/512/5450/5450144.png",
                                        fit: BoxFit.cover,
                                        width: screenWidth * 0.16,
                                        height: screenWidth * 0.10,
                                        errorBuilder: (context, error, stackTrace) {
                                          setState(() {
                                            hasRenderingIssue = true; // Set flag if there's an error
                                          });
                                          return Center(child: Icon(Icons.error, color: Colors.red));
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Container(
                                    width: screenWidth * 0.16,
                                    child: Text(
                                      category.title,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: textOverflows ? 1 : 2,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.03, // Font size relative to screen width
                                        color: isSelected ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        );
      },
    );
  }
}
