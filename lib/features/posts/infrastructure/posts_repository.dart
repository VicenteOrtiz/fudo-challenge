import '../domain/post.dart';
import 'datasource/posts_datasource.dart';

class PostsRepository {
  final PostsDataSource dataSource;

  PostsRepository(this.dataSource);

  Future<List<Post>> getPosts() async {
    return await dataSource.getPosts();
  }
}
