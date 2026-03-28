import 'package:dokan/features/home/domain/entities/bag/cart_item.dart';

class CartItemModel extends CartItem {
  CartItemModel({
    required super.name,
    required super.image,
    required super.productId,
    required super.price,
    required super.quantity,
    required super.discount,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      name: json["name"],
      image: json["image"],
      productId: json["productId"],
      price: (json["price"] as num).toDouble(),
      quantity: (json["quantity"] as num).toInt(),
      discount: (json["discount"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
      "product_id": productId,
      "price": price,
      "quantity": quantity,
      "discount": discount,
    };
  }
}
