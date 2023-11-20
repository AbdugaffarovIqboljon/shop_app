class ProductModel {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is ProductModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          price == other.price &&
          description == other.description &&
          category == other.category &&
          image == other.image &&
          rating == other.rating;

  @override
  int get hashCode => Object.hash(id, title,  category, rating);

  factory ProductModel.fromJson(Map<String, Object?> json) => ProductModel(
        id: json["id"] as int,
        title: json["title"] as String,
        price: json["price"] as num,
        description: json["description"] as String,
        category: json["category"] as String,
        image: json["image"] as String,
        rating: Rating.fromJson(json["rating"] as Map<String, Object?>),
      );
}

class Rating {
  final num rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, Object?> json) => Rating(
        rate: json["rate"] as num,
        count: json['count'] as int,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Rating &&
          runtimeType == other.runtimeType &&
          rate == other.rate &&
          count == other.count;

  @override
  int get hashCode => Object.hash(rate, count);
}
