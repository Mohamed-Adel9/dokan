import 'package:dokan/features/home/domain/entities/bag/cart_item.dart';

class OrderItemModel extends CartItem {

  const OrderItemModel({
    required super.productId,
    required super.name,
    required super.image,
    required super.price,
    required super.quantity,
    required super.discount,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['productId'],
      name: json['name'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "name": name,
      "image": image,
      "price": price,
      "quantity": quantity,
      "discount": discount,
    };
  }
}