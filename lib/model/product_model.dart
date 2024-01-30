class ProductModel {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;
  late final Rating rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rate': rating.rate,
      'count': rating.count,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
  }

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

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
