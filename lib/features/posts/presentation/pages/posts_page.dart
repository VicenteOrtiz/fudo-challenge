import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_challenge/app/presentation/app_theme.dart';
import 'package:fudo_challenge/features/posts/presentation/widgets/post_list_widget.dart';
import 'package:fudo_challenge/features/posts/presentation/widgets/search_bar_widget.dart';
import '../../../../core/config/shared_preferences/app_preferences.dart';
import '../bloc/posts_bloc.dart';
import 'add_post_page.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    super.initState();
    // Load posts when the screen is initialized
    BlocProvider.of<PostsBloc>(context).add(LoadPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorPrimary.primaryColor,
        title: const Text(
          'Posts',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: () {
            context.read<PostsBloc>().add(LoadPosts());
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              // Implement logout functionality
              final appPreferences = AppPreferences();
              appPreferences.isAuthenticated = false;
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        listener: (context, state) {
          if (state is PostsLoaded &&
              state.isFromCache &&
              state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PostsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostsLoaded) {
            return Column(
              children: [
                const SearchBarWidget(),
                Expanded(child: PostListWidget()),
              ],
            );
          } else if (state is PostsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No posts available'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPrimary.primaryColor,
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddPostPage()),
          );
          if (result != null) {
            context.read<PostsBloc>().add(AddPost(result));
          }
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
