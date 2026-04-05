import 'package:dokan/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity{


  UserModel({
    required super.id,
    required super.name,
    required super.email,
  });


  factory UserModel.fromjson(Map<String,dynamic>json){
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'name': name,
      'email': email,
      'createdAt': DateTime.now(),
    };
  }
}