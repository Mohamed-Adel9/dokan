import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/features/home/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.category,
    required super.price,
    required super.productName,
    required super.rate,
    required super.image,
    required super.discount,
    required super.categoryName,
    required super.createdAt,
    required super.isFavorite, required super.info,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      category: json['category'],
      categoryName: json['category_name'],
      price: (json['price'] as num).toDouble(),
      productName: json['productName'],
      rate: json['rate'],
      image: json['image'],
      discount: json['discount'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      isFavorite: json['isFavorite'],
      info: json['info'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'category_name': categoryName,
      'price': price,
      'productName': productName,
      'rate': rate,
      'image': image,
      'discount': discount,
      'createdAt': createdAt,
      'isFavorite': isFavorite,
      "info":info,
    };
  }
}
