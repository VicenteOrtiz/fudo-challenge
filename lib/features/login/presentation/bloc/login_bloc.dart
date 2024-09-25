import 'package:bloc/bloc.dart';
import 'package:fudo_challenge/cross-features/auth/infrastructure/auth_repository.dart';
import 'package:meta/meta.dart';

import '../../../../core/config/shared_preferences/app_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  var appPreferences = AppPreferences();

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<Login>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    Login event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      await authRepository.login(event.email, event.password);
      appPreferences.isAuthenticated = true;
      emit(LoginSuccess());
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}
