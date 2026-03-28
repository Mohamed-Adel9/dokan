import 'package:dokan/features/home/domain/entities/bag/cart_item.dart';

class OrderEntity {
  final String userId;
  final String paymentMethod;
  final String status;
  final double totalPrice;
  final double deliveryPrice;
  final String address;
  final String city;
  final String country;
  final DateTime createdAt;
  final List<CartItem> item ;

  const OrderEntity({
    required this.userId,
    required this.paymentMethod,
    required this.totalPrice,
    required this.deliveryPrice,
    required this.address,
    required this.city,
    required this.country,
    required this.status,
    required this.createdAt,
    required this.item,
  });
}