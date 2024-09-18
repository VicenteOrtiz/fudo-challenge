import 'datasource/auth_datasource.dart';

class AuthRepository {
  final AuthDataSource dataSource;

  AuthRepository(this.dataSource);

  Future<String> login(String email, String password) async {
    return await dataSource.login(email, password);
  }
}
