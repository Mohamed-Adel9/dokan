import '../../repositories/bag/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  Future<void> call(String productId) {
    return repository.removeFromCart(productId);
  }
}