import 'package:expense_tracker_app/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:expense_tracker_app/features/auth/domain/repo_interfaces/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<bool> login(String email, String password) async {
    if (email == 'most890@gmail.com' && password == 'most890') {
      await localDataSource.cashLoginStatus(true);
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() {
    return localDataSource.clearLoginStatus();
  }

  @override
  Future<bool> isLoggedIn() {
    return localDataSource.getLoginStatus();
  }
}
