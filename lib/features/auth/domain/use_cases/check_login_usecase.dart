import 'package:expense_tracker_app/features/auth/domain/repo_interfaces/auth_repository.dart';

class CheckLoginUsecase {
  final AuthRepository authRepository;

  CheckLoginUsecase(this.authRepository);

  Future<bool> execute() async{
    // هنا بنستخدم ال authRepository علشان نعرف اذا كان المستخدم مسجل دخول بالفعل
    return await authRepository.isLoggedIn();
  }
}