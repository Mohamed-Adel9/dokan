import 'package:dokan/features/home/domain/repositories/bag/cart_repository.dart';

class UpdateCartItemUseCase {
  final CartRepository repository ;

  UpdateCartItemUseCase({required this.repository});

  Future<void> call(String productId, int quantity)async{
    return await repository.updateQuantity(productId,quantity);
  }
}