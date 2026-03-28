import 'package:dokan/features/checkout/domain/entity/order_entity.dart';
import 'package:dokan/features/checkout/domain/repository/order_repository.dart';

class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase({required this.repository});

  Future<void> call(OrderEntity order) {
    return repository.createOrder(order);
  }
}
