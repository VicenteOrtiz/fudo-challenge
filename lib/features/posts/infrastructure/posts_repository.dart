import '../domain/post.dart';
import 'datasource/posts_datasource.dart';
import 'models/response_model.dart';

class PostsRepository {
  final PostsDataSource dataSource;

  PostsRepository(this.dataSource);

  Future<ResponseModel<List<Post>>> getPosts() async {
    try {
      final posts = await dataSource.getPosts();
      return ResponseModel(data: posts, isFromCache: false);
    } catch (e) {
      // If fetching fails, try to get cached posts
      try {
        final cachedPosts = await dataSource.getCachedPosts();
        return ResponseModel(
          data: cachedPosts,
          isFromCache: true,
          message: 'No internet connection.',
        );
      } catch (cacheError) {
        throw Exception('Failed to load posts: ${cacheError.toString()}');
      }
    }
  }
}
