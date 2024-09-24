import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/app_theme.dart';
import '../bloc/posts_bloc.dart';

class PostListWidget extends StatelessWidget {
  const PostListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is PostsInitial) {
          context.read<PostsBloc>().add(LoadPosts());
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostsLoaded) {
          return state.posts.isEmpty
              ? const Center(child: Text('No posts found'))
              : ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.body),
                      leading: CircleAvatar(
                        backgroundColor: ColorPrimary.primaryColor,
                        child: Text(
                          post.userId.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                );
        } else if (state is PostsError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container();
      },
    );
  }
}
