import 'package:dokan/features/home/domain/entities/product.dart';
import 'package:dokan/features/home/domain/repositories/home_repository.dart';

class GetProductUseCase {
  final HomeRepository repository ;

  GetProductUseCase({required this.repository});

  Stream<List<Product>> call () {
    return repository.getProducts();
  }
}