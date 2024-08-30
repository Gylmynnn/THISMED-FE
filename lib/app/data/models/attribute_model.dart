class AttributeModel {
  int id;
  String username;
  String? avatar;
  String? bio;
  List<dynamic>? badges;
  String? userId;

  AttributeModel({
    required this.id,
    required this.username,
    this.avatar,
    this.bio,
    this.badges,
    this.userId,
  });

  factory AttributeModel.fromJson(Map<String, dynamic> json) {
    return AttributeModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      avatar: json['avatar'] ?? '',
      bio: json['bio'] ?? '',
      badges: json['badges'] ?? [''],
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'avatar': avatar ?? '',
      'bio': bio ?? '',
      'badges': badges ?? [''],
      'userId': userId ?? '',
    };
  }
}
