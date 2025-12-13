class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final Map<String, dynamic> rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      imageUrl: json['image'] as String,
      rating: json['rating'] as Map<String, dynamic>,
    );
  }
}
