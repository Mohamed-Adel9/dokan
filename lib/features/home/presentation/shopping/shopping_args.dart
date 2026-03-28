import '../../domain/entities/product.dart';

class ShoppingArgs {
  final List<Product> products;
  final String categoryName;
  final String categoryKind;

  ShoppingArgs({
    required this.products,
    required this.categoryName,
    required this.categoryKind,
  });
}