import 'package:expense_tracker_app/features/auth/domain/entities/login_credentials.dart';
import 'package:expense_tracker_app/features/auth/domain/repo_interfaces/auth_repository.dart';

class LoginUsecase {
  
  final AuthRepository authRepository;

  // هنا بنعمل انجيكشن لل AuthRepository 
  // علشان نقدر نستخدمه فى ال usecase
  LoginUsecase(this.authRepository);

  Future<bool> execute(LoginCredentials credentials) async {
    // بنستخدم ال authRepository علشان نسجل دخول المستخدم
    return await authRepository.login(
      credentials.email,
      credentials.password,
       );

  }


}