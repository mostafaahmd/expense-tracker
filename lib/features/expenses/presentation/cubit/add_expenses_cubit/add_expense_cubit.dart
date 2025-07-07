import 'package:expense_tracker_app/features/expenses/domain/entities/expense.dart';
import 'package:expense_tracker_app/features/expenses/domain/use_cases/add_expense_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  final AddExpenseUseCase addExpenseUC;

  AddExpenseCubit(this.addExpenseUC) : super(AddExpenseInitial());

  Future<void> submitExpense(Expense expense) async {
    emit(AddExpenseLoading());
    try {
      await addExpenseUC.execute(expense);
      emit(AddExpenseSuccess());
    } catch (e) {
      emit(AddExpenseError(e.toString()));
    }
  }

  void reset() => emit(AddExpenseInitial());
}
