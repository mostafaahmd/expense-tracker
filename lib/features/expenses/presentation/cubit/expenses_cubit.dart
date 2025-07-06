import 'package:bloc/bloc.dart';


import '../../domain/use_cases/get_recent_expenses_usecase.dart';
import '../../domain/use_cases/get_balance_usecase.dart';
import 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  final GetRecentExpensesUseCase _getRecent;
  final GetBalanceUseCase _getBalance;

  ExpensesCubit(this._getRecent, this._getBalance) : super(const ExpensesInitial());

  /// يحمل البيانات للمرة الأولى أو بعد فلترة/تحديث
  Future<void> loadDashboard({
    int count = 10,
  }) async {
    try {
      emit(const ExpensesLoading());
      final recent   = await _getRecent.execute(count: count);
      final balance  = await _getBalance.execute();
      emit(ExpensesLoaded(expenses: recent, balance: balance));
    } catch (e) {
      emit(ExpensesError(e.toString()));
    }
  }
}
