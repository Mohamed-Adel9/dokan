import 'package:dokan/features/checkout/domain/entity/order_entity.dart';

abstract class OrderRepository {
  Future<void> createOrder(OrderEntity order);
}