
import '../../domain/entities/categories.dart';

class CategoriesModel extends Categories {
  CategoriesModel({
    required super.category,
    required super.item,
    required super.image
  });


  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      category: json['category'],
      item: json['item'],
      image: json['image'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'item': item,
      'image': image,

    };
  }
}
