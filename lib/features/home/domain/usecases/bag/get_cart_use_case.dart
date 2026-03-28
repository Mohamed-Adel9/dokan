import '../../entities/bag/cart_item.dart';
import '../../repositories/bag/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  Stream<List<CartItem>> call() {
    return repository.getCartItems();
  }
}