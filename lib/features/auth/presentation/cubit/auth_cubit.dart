import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/login_credentials.dart';
import '../../domain/use_cases/login_usecase.dart';
import '../../domain/use_cases/check_login_usecase.dart';
import '../../domain/use_cases/logout_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase _loginUC;
  final CheckLoginUsecase _checkUC;
  final LogoutUsecase _logoutUC;

  AuthCubit(this._loginUC, this._checkUC, this._logoutUC)
    : super(AuthInitial());

  // دالة للتحقق من حالة الدخول عند الإقلاع
  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final loggedIn = await _checkUC.execute();
    emit(loggedIn ? AuthAuthenticated() : AuthUnauthenticated());
  }

  // دالة تسجيل الدخول
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final success = await _loginUC.execute(
      LoginCredentials(email: email, password: password)
    );
    emit(success ? AuthAuthenticated() : AuthError('Email or password wrong'));
  }

  // دالة تسجيل الخروج
  Future<void> logout() async {
    emit(AuthLoading());
    await _logoutUC.execute();
    emit(AuthUnauthenticated());
  }
}
