part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<Post> posts;
  final String searchQuery;

  PostsLoaded(this.posts, {this.searchQuery = ''});
}

class PostsError extends PostsState {
  final String message;

  PostsError(this.message);
}
