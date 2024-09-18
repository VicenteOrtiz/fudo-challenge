import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cross-features/auth/infrastructure/auth_repository.dart';
import 'cross-features/auth/infrastructure/datasource/auth_datasource.dart';
import 'cross-features/auth/infrastructure/datasource/mock_auth_datasource.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/login/presentation/login_page.dart';

void main() {
  //final AuthDataSource authDataSource = AuthDataSourceImpl(Dio());
  final AuthDataSource authDataSource = MockAuthDataSource();
  final AuthRepository authRepository = AuthRepository(authDataSource);

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authRepository: authRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
