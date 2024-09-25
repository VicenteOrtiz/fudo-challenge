import 'package:dio/dio.dart';
import 'package:fudo_challenge/secrets.dart';

abstract class AuthDataSource {
  Future<String> login(String email, String password);
}

class AuthDataSourceImpl implements AuthDataSource {
  final Dio _dio;

  AuthDataSourceImpl(this._dio);

  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post('$baseUrl/login', data: {
        'email': email,
        'password': password,
      });
      return response.data['token'];
    } catch (e) {
      throw Exception('Failed to login');
    }
  }
}
