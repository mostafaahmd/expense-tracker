import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

// Data Layer
import 'features/auth/data/data_sources/auth_local_data_source.dart';
import 'features/auth/data/repo_implementation/auth_repo_implementation.dart';

// Domain Layer
import 'features/auth/domain/use_cases/login_usecase.dart';
import 'features/auth/domain/use_cases/check_login_usecase.dart';
import 'features/auth/domain/use_cases/logout_usecase.dart';

// Presentation Layer
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/dashboard_screen.dart';

void main() async{
  // تهيئة Flutter
  // هنا بنعمل تهيئة لل Flutter علشان نقدر نستخدمه
  WidgetsFlutterBinding.ensureInitialized();
  // تهيئة Hive
  await Hive.initFlutter();
  //فتح صندوق البيانات
  // هنا بنفتح صندوق البيانات اللى هنعمل فيه تخزين البيانات
  final box = await Hive.openBox('appBox');

  final localDataSource = AuthLocalDataSourceImpl(box);

  final authRepository = AuthRepositoryImpl(localDataSource);

  final loginUsecase = LoginUsecase(authRepository);

  final checkLoginUsecase = CheckLoginUsecase(authRepository);

  final logoutUsecase = LogoutUsecase(authRepository);

  runApp(
    BlocProvider(
      create: (_) => AuthCubit(loginUsecase, checkLoginUsecase, logoutUsecase)
        ..checkAuthStatus(), // التحقق من حالة الدخول عند الإقلاع
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker Lite',
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return const DashboardScreen();
          } else if (state is AuthUnauthenticated) {
            return const LoginScreen();
          }
          // أثناء التحقق
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

