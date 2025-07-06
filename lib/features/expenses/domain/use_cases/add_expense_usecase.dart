// lib/features/expenses/domain/use_cases/add_expense_usecase.dart

import 'package:expense_tracker_app/features/expenses/domain/repo_interface/expenses_repository.dart';

import '../entities/expense.dart';

class AddExpenseUseCase {
  final ExpensesRepository repository;

  AddExpenseUseCase(this.repository);

  Future<void> execute(Expense expense) {
    return repository.addExpense(expense);
  }
}
