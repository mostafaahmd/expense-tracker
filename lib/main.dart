import 'package:expense_tracker_app/features/expenses/data/models/expense_model.dart';
import 'package:expense_tracker_app/features/expenses/presentation/cubit/add_expenses_cubit/add_expense_cubit.dart';
import 'package:expense_tracker_app/features/expenses/presentation/cubit/dashboard_expenses_cuibt/expenses_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

// Auth Data Layer
import 'features/auth/data/data_sources/auth_local_data_source.dart';
import 'features/auth/data/repo_implementation/auth_repo_implementation.dart';
// Auth Domain Layer
import 'features/auth/domain/use_cases/login_usecase.dart';
import 'features/auth/domain/use_cases/check_login_usecase.dart';
import 'features/auth/domain/use_cases/logout_usecase.dart';
// Auth Presentation Layer
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/screens/login_screen.dart';

// Expenses Data Layer
import 'features/expenses/data/data_sources/expenses_local_data_source.dart';
import 'features/expenses/data/data_sources/currenct_api_service.dart';
import 'features/expenses/data/repo_implementations/expenses_repository_imp.dart';
// Expenses Domain Layer
import 'features/expenses/domain/use_cases/get_recent_expenses_usecase.dart';
import 'features/expenses/domain/use_cases/get_balance_usecase.dart';
import 'features/expenses/domain/use_cases/add_expense_usecase.dart'; // << جديد
// Expenses Presentation Layer
import 'features/expenses/presentation/screens/dashboard_screen.dart';
import 'features/expenses/presentation/screens/add_expense_screen.dart'; // << جديد

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // --- إعداد Auth Layer ---
  final authBox = await Hive.openBox('appBox');
  final authLocalDS   = AuthLocalDataSourceImpl(authBox);
  final authRepo      = AuthRepositoryImpl(authLocalDS);
  final loginUC       = LoginUsecase(authRepo);
  final checkLoginUC  = CheckLoginUsecase(authRepo);
  final logoutUC      = LogoutUsecase(authRepo);

  // --- إعداد Expenses Layer ---
  Hive.registerAdapter(ExpenseModelAdapter());
  final expenseBox   = await Hive.openBox<ExpenseModel>('expensesBox');
  final expensesDS   = ExpensesLocalDataSourceImpl(expenseBox);
  final currencySvc  = CurrencyApiServiceImpl();
  final expensesRepo = ExpensesRepositoryImpl(expensesDS, currencySvc);
  final getRecentUC  = GetRecentExpensesUseCase(expensesRepo);
  final getBalanceUC = GetBalanceUseCase(expensesRepo);
  final addExpenseUC = AddExpenseUseCase(expensesRepo); // << جديد

  runApp(
    MultiBlocProvider(
      providers: [
        // AuthCubit provider
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(loginUC, checkLoginUC, logoutUC)
            ..checkAuthStatus(),
        ),
        // ExpensesCubit provider
        BlocProvider<ExpensesCubit>(
          create: (_) => ExpensesCubit(getRecentUC, getBalanceUC),
        ),
        // AddExpenseCubit provider
        BlocProvider<AddExpenseCubit>(
          create: (_) => AddExpenseCubit(addExpenseUC),
        ),
      ],
      child: const MyApp(),
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
      routes: {
        '/': (_) => const _RootScreen(),
        '/add_expense_screen': (_) => const AddExpenseScreen(),
      },
      initialRoute: '/',
    );
  }
}

/// شاشة الجذر: تسجيل الدخول أو الداشبورد حسب الحالة
class _RootScreen extends StatelessWidget {
  const _RootScreen();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is AuthAuthenticated) {
          return const DashboardScreen();
        }
        return const LoginScreen();
      },
    );
  }
}