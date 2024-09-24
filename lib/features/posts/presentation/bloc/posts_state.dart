part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<Post> posts;
  final String searchQuery;
  final bool isFromCache;
  final String? message;

  PostsLoaded(
    this.posts, {
    this.searchQuery = '',
    this.isFromCache = false,
    this.message,
  });
}

class PostsError extends PostsState {
  final String message;

  PostsError(this.message);
}
