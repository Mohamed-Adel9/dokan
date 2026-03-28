import 'package:dokan/features/home/domain/entities/product.dart';

class ProductScreenArgs {
  final String categoryName;
  final String categoryKind;
  final Product products;

  ProductScreenArgs({
    required this.categoryName,
    required this.products,
    required this.categoryKind,
  });
}