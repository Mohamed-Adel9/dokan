import 'package:dokan/features/home/domain/entities/product.dart';

abstract class HomeRepository {
  Stream<List<Product>> getProducts() ;
}