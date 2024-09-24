import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/post.dart';
import '../../infrastructure/models/response_model.dart';
import '../../infrastructure/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository repository;
  List<Post> _allPosts = [];

  PostsBloc({required this.repository}) : super(PostsInitial()) {
    on<LoadPosts>(_onLoadPosts);
    on<SearchPosts>(_onSearchPosts);
  }

  Future<void> _onLoadPosts(LoadPosts event, Emitter<PostsState> emit) async {
    emit(PostsLoading());
    try {
      final ResponseModel<List<Post>> response = await repository.getPosts();
      _allPosts = response.data;
      emit(PostsLoaded(
        _allPosts,
        isFromCache: response.isFromCache,
        message: response.message,
      ));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }

  void _onSearchPosts(SearchPosts event, Emitter<PostsState> emit) {
    if (_allPosts.isEmpty) return;

    final filteredPosts = _filterPosts(_allPosts, event.query);
    emit(PostsLoaded(filteredPosts, searchQuery: event.query));
  }

  List<Post> _filterPosts(List<Post> posts, String query) {
    if (query.isEmpty) return posts;

    // Mock user data
    final mockUsers = {
      1: 'John Wick',
      2: 'Sarah Connor',
      3: 'Tony Stark',
      4: 'Lara Croft',
      5: 'Bruce Wayne',
    };

    return posts.where((post) {
      final userName = mockUsers[post.userId]?.toLowerCase() ?? '';
      return userName.contains(query.toLowerCase()) ||
          post.title.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
