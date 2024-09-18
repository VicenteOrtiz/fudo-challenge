import 'dart:async';
import 'dart:developer';
import 'auth_datasource.dart';

class MockAuthDataSource implements AuthDataSource {
  final Duration delay;

  final Map<String, String> _users = {
    'challenge@fudo': 'password',
  };

  MockAuthDataSource({this.delay = const Duration(milliseconds: 500)});

  @override
  Future<String> login(String email, String password) async {
    await Future.delayed(delay);
    if (_users.containsKey(email) && _users[email] == password) {
      return 'mock_token_${email.split('@')[0]}';
    } else {
      throw Exception('Invalid email or password');
    }
  }
}
