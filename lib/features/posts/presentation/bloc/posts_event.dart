part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}

class LoadPosts extends PostsEvent {}

class SearchPosts extends PostsEvent {
  final String query;

  SearchPosts(this.query);
}
