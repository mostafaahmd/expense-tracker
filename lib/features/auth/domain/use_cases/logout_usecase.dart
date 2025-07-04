import 'package:expense_tracker_app/features/auth/domain/repo_interfaces/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;

  LogoutUsecase(this.authRepository);
  Future<void> execute() async {
    // هنا بنستخدم ال authRepository علشان نعمل تسجيل خروج للمستخدم
    await authRepository.logout();
  }
}