import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_challenge/core/config/routes/routes_generator.dart';
import 'core/config/shared_preferences/app_preferences.dart';
import 'cross-features/auth/infrastructure/auth_repository.dart';
import 'cross-features/auth/infrastructure/datasource/auth_datasource.dart';
import 'cross-features/auth/infrastructure/datasource/mock_auth_datasource.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/posts/infrastructure/datasource/posts_datasource.dart';
import 'features/posts/infrastructure/posts_repository.dart';
import 'features/posts/presentation/bloc/posts_bloc.dart';

void main() async {
  //final AuthDataSource authDataSource = AuthDataSourceImpl(Dio());
  WidgetsFlutterBinding.ensureInitialized();

  final appPreferences = AppPreferences();
  await appPreferences.initPrefs();

  final AuthDataSource authDataSource = MockAuthDataSource();
  final AuthRepository authRepository = AuthRepository(authDataSource);

  final postsDataSource = PostsDataSourceImpl(Dio());
  final postsRepository = PostsRepository(postsDataSource);

  runApp(MyApp(
    authRepository: authRepository,
    postsRepository: postsRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final PostsRepository postsRepository;

  const MyApp(
      {super.key, required this.authRepository, required this.postsRepository});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authRepository: authRepository),
        ),
        BlocProvider<PostsBloc>(
          create: (context) => PostsBloc(repository: postsRepository),
        ),
      ],
      child: const MaterialApp(
        title: "Fudo Challenge App",
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
