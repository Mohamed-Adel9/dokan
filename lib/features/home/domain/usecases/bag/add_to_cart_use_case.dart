import 'package:dokan/features/home/domain/entities/bag/cart_item.dart';

import '../../repositories/bag/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<void> call(CartItem item) {
    return repository.addToCart(item);
  }
}