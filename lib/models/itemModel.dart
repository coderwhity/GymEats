class FoodItem {
  final String id;
  final String name;
  final bool isNonVeg;
  final double proteins; // Assuming proteins are stored as a double
  final double calories; // Changed to double for fractional values
  final String image;
  final String quantityType;
  FoodItem({
    required this.id,
    required this.name,
    required this.isNonVeg,
    required this.proteins,
    required this.calories,
    required this.image,
    required this.quantityType,
  });

  // Factory method to create a FoodItem from a JSON map
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'] as String,
      name: json['name'] as String,
      isNonVeg: json['isNonVeg'] as bool,
      proteins: double.parse(json['proteins'].toString()),
      calories: double.parse(json['calories'].toString()),
      image: json['image'] as String,
      quantityType: json['quantityType'],
    );
  }

  // Method to convert FoodItem to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isNonVeg': isNonVeg,
      'proteins': proteins,
      'calories': calories, // Changed to double
      'image': image,
      'quantityType': quantityType,
    };
  }
}
