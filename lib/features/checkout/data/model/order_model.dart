import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/features/checkout/domain/entity/order_entity.dart';

import 'item_model.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.userId,
    required super.paymentMethod,
    required super.totalPrice,
    required super.deliveryPrice,
    required super.address,
    required super.city,
    required super.country,
    required super.status,
    required super.createdAt,
    required super.item,
  });

  factory OrderModel.fromJson(Map<String,dynamic>json){
    return OrderModel(
        userId: json['userId'],
        paymentMethod: json['paymentMethod'],
        totalPrice: (json['totalPrice']as num).toDouble(),
        deliveryPrice: (json['deliveryPrice']as num).toDouble(),
        address: json['address'],
        city: json['city'],
        country: json['country'],
        status: json['status'],
        createdAt: (json['createdAt']as Timestamp).toDate(),
        item:(json['items'] as List)
            .map((e) => OrderItemModel.fromJson(e))
            .toList(),
    );
  }
  Map<String,dynamic> toJson(){
    return{
      "userId":userId,
      "paymentMethod":paymentMethod,
      "totalPrice":totalPrice,
      "deliveryPrice":deliveryPrice,
      "address":address,
      "city":city,
      "country":country,
      "status":status,
      "createdAt":createdAt,
      "item": item.map((e) => (e as OrderItemModel).toJson()).toList(),
    };
  }
}
