import 'package:dio/dio.dart';
import '../../domain/post.dart';
import 'database_helper.dart';

abstract class PostsDataSource {
  Future<List<Post>> getPosts();
  Future<void> cachePosts(List<Post> posts);
  Future<List<Post>> getCachedPosts();
  Future<Post> addPost(Post post);
}

class PostsDataSourceImpl implements PostsDataSource {
  final Dio _dio;
  final DatabaseHelper _dbHelper;

  PostsDataSourceImpl(this._dio) : _dbHelper = DatabaseHelper.instance;

  @override
  Future<Post> addPost(Post post) async {
    try {
      final response = await _dio.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: post.toJson(),
      );
      if (response.statusCode == 201) {
        return Post.fromJson(response.data);
      } else {
        throw Exception('${response.statusCode}: Failed to add post');
      }
    } catch (e) {
      throw Exception('Failed to add post');
    }
  }

  @override
  Future<List<Post>> getPosts() async {
    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts');
      if (response.statusCode == 200) {
        final posts =
            (response.data as List).map((json) => Post.fromJson(json)).toList();
        await cachePosts(posts);
        return posts;
      } else {
        throw Exception('${response.statusCode}: Failed to load posts');
      }
    } catch (e) {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<void> cachePosts(List<Post> posts) async {
    await _dbHelper.deleteAllPosts(); // Clear existing posts
    await _dbHelper.insertPosts(posts);
  }

  @override
  Future<List<Post>> getCachedPosts() async {
    return await _dbHelper.getPosts();
  }
}
