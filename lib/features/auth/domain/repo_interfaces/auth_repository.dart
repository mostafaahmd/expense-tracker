abstract class AuthRepository {
// يسجل دخول المستخدم
  Future<bool> login(String email, String password);
//يمسح تسجيل الدخول المسجله
  Future<void> logout();
//فى حالة ان ال user مسجل دخول بالفعل
  Future<bool> isLoggedIn();
}