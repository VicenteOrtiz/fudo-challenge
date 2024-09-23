import 'package:flutter/material.dart';

import '../../../features/login/presentation/pages/login_page.dart';
import '../../../features/posts/presentation/pages/posts_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/posts':
        return MaterialPageRoute(builder: (_) => const PostsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Error: Route not found!'),
            ),
          ),
        );
    }
  }
}
