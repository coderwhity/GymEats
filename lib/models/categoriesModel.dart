class CategoriesModel {
  final String image;
  final String id;
  final String title;

  CategoriesModel({
    required this.image,
    required this.id,
    required this.title,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      image: json['image'] as String,
      id: json['id'] as String,
      title: json['title'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'id': id,
      'title': title,
    };
  }
}
