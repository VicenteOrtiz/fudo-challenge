import '../../domain/post.dart';

class PostDto {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post toDomain() {
    return Post(
      userId: userId,
      id: id,
      title: title,
      body: body,
    );
  }

  PostDto(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory PostDto.fromJson(Map<String, dynamic> json) {
    return PostDto(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
