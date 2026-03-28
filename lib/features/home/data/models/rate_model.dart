import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/features/home/domain/entities/rate.dart';

class RateModel extends Rate {
  RateModel({
    required super.rate,
    required super.review,
    required super.time,
    required super.image,
    required super.userName,

  });

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      rate: json['rate'],
      review: json['review'],
      userName: json['user_name'],
      image: json['image'],
      time: (json['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'review': review,
      'image': image,
      'date': time,
      'user_name': userName,
    };
  }
}
