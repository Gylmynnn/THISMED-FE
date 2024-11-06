import 'package:thismed/app/data/models/comment_model.dart';
import 'package:thismed/app/data/models/intraction_model.dart';
import 'package:thismed/app/data/models/user_model.dart';

class PostModel {
  int id;
  String title;
  String? image;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? category;
  String? userId;
  UserModel? users;
  List<CommentModel>? comments;
  List<IntractionModel>? intractions;

  PostModel({
    required this.id,
    required this.title,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.userId,
    this.users,
    this.comments,
    this.intractions,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    List<CommentModel>? comments = [];
    if (json['comments'] != null) {
      comments = List<CommentModel>.from(
        json['comments'].map(
          (json) => CommentModel.fromJson(json),
        ),
      );
    }
    List<IntractionModel>? intractions = [];
    if (json['intractions'] != null) {
      intractions = List<IntractionModel>.from(
        json['intractions'].map(
          (json) => IntractionModel.fromJson(json),
        ),
      );
    }
    return PostModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      category: json['category'] ?? [''],
      userId: json['userId'] ?? '',
      users: json['users'] != null ? UserModel.fromJson(json['users']) : null,
      comments: comments,
      intractions: intractions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image ?? '',
      'createdAt': createdAt ?? '',
      'updatedAt': updatedAt ?? '',
      'category': category ?? [''],
      'userId': userId ?? '',
      'users': users ?? '',
      'comments': comments ?? '',
      'intractions': intractions ?? '',
    };
  }
}
