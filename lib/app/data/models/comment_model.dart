import 'package:thismed/app/data/models/user_model.dart';

class CommentModel {
  int id;
  String content;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? postId;
  String? userId;
  UserModel? users;

  CommentModel({
    required this.id,
    required this.content,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.postId,
    this.userId,
    this.users,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? 0,
      content: json['content'] ?? '',
      image: json['image'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      postId: json['postId'] ?? 0,
      userId: json['userId'] ?? '',
      users: json['users'] != null ? UserModel.fromJson(json['users']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'image': image ?? '',
      'createdAt': createdAt ?? '',
      'updatedAt': updatedAt ?? '',
      'postId' : postId ?? 0,
      'userId': userId ?? '',
      'users': users ?? '',
    };
  }
}
