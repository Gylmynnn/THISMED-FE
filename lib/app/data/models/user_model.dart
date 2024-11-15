import '../models/attribute_model.dart';

class UserModel {
  String id;
  String email;
  String? password;
  String? token;
  String? createdAt;
  String? updatedAt;
  AttributeModel? attribute;

  UserModel({
    required this.id,
    required this.email,
    this.password,
    this.token,
    this.createdAt,
    this.updatedAt,
    this.attribute,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      token: json['token'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      attribute: json['attribute'] != null
          ? AttributeModel.fromJson(json['attribute'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password ?? '',
      'token': token ?? '',
      'createdAt': createdAt ?? '',
      'updatedAt': updatedAt ?? '',
      'attribute': attribute ?? ''
    };
  }
}
