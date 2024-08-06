class BasketItemModel {
  final String id;
  final String name;
  final bool isNonVeg;
  final double proteins; // Assuming proteins are stored as a double
  final double calories; // Changed to double for fractional values
  final String image;
  int quantity;
  final String quantityType;

  BasketItemModel(
      {required this.id,
      required this.name,
      required this.isNonVeg,
      required this.proteins,
      required this.calories,
      required this.image,
      required this.quantity,
      required this.quantityType});

  // Factory method to create a BasketItemModel from a JSON map
  factory BasketItemModel.fromJson(Map<String, dynamic> json) {
    return BasketItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isNonVeg: json['isNonVeg'] as bool,
      proteins: json['proteins'] as double,
      calories: json['calories'] as double, // Changed to double
      image: json['image'] as String,
      quantity: json['quantity'] as int,
      quantityType: json['quantityType'],
    );
  }

  // Method to convert BasketItemModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isNonVeg': isNonVeg,
      'proteins': proteins,
      'calories': calories, // Changed to double
      'image': image,
      'quantity': quantity,
      'quantityType': quantityType,
    };
  }

  // Method to convert BasketItemModel to a JSON map
  Map<String, dynamic> toGeminDataJson() {
    String quantityString = quantity.toString();
    print(quantityType);
    if (quantityType != 'incremental') {
      quantityString += " gm";
    }
    return {
      'name': name,
      'quantity': quantityString,
    };
  }
}
