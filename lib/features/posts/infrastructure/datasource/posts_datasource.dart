import 'package:dio/dio.dart';
import '../../domain/post.dart';

abstract class PostsDataSource {
  Future<List<Post>> getPosts();
}

class PostsDataSourceImpl implements PostsDataSource {
  final Dio _dio;

  PostsDataSourceImpl(this._dio);

  @override
  Future<List<Post>> getPosts() async {
    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => Post.fromJson(json))
            .toList();
      } else {
        throw Exception('${response.statusCode}: Failed to load posts');
      }
    } catch (e) {
      throw Exception('Failed to load posts');
    }
  }
}
