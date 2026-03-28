
class Product {
  final String id;
  final String productName;
  final String category;
  final String categoryName;
  final DateTime createdAt;
  final String image;
  final double price;
  final int rate;
  final int discount;
  final bool isFavorite;

  Product({
    required this.id,
    required this.productName,
    required this.category,
    required this.price,
    required this.rate,
    required this.image,
    required this.discount,
    required this.categoryName,
    required this.createdAt,
    required this.isFavorite,
  });
  Product copyWith({
    bool? isFavorite,
  }) {
    return Product(
      id: id,
      productName: productName,
      image: image,
      price: price,
      discount: discount,
      categoryName: categoryName,
      category: category,
      createdAt: createdAt,
      rate: rate,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  double get finalPrice => price - (price * (discount / 100));
  bool get hasDiscount => discount > 0;
}
