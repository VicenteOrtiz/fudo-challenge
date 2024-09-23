import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_challenge/app/presentation/app_theme.dart';
import '../bloc/posts_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPrimary.primaryColor,
        title: const Text(
          'Posts',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              // TODO: Implement logout functionality
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _SearchBar(),
          Expanded(child: _PostsList()),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search by user name or post title...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onChanged: (query) {
          context.read<PostsBloc>().add(SearchPosts(query));
        },
      ),
    );
  }
}

class _PostsList extends StatelessWidget {
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
