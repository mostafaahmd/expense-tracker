import 'package:hive/hive.dart';

abstract class AuthLocalDataSource {
  Future<bool> getLoginStatus();

  Future<void> cashLoginStatus(bool isLoggedIn);

  Future<void> clearLoginStatus();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // هنا بنعمل انجيكشن لل Hive
  final Box box;

  AuthLocalDataSourceImpl(this.box);

  @override
  Future<void> cashLoginStatus(bool isLoggedIn) {
    return box.put('isLoggedIn', isLoggedIn);
  }

  @override
  Future<void> clearLoginStatus() {
    return box.put('isLoggedIn', false);
  }

  @override
  Future<bool> getLoginStatus() {
    return Future.value(box.get('isLoggedIn', defaultValue: false) as bool);
  }
}
