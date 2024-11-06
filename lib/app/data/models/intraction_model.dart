class IntractionModel {
  final int id;
  final int? postId;
  final String? userId;
  final bool liked;
  final String? createdAt;

  IntractionModel({
    required this.id,
    this.postId,
    this.userId,
    required this.liked,
    this.createdAt,
  });

  factory IntractionModel.fromJson(Map<String, dynamic> json) {
    return IntractionModel(
      id: json['id'],
      postId: json['postId'] ?? 0,
      userId: json['userId'] ?? "",
      liked: json['liked'],
      createdAt: json['createdAt'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId ?? 0,
      'userId': userId ?? "",
      'liked': liked,
      'createdAt': createdAt ?? ""
    };
  }
}
