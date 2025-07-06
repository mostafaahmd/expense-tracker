// lib/features/expenses/domain/use_cases/get_recent_expenses_usecase.dart

import 'package:expense_tracker_app/features/expenses/domain/repo_interface/expenses_repository.dart';

import '../entities/expense.dart';

class GetRecentExpensesUseCase {
  final ExpensesRepository repository;

  GetRecentExpensesUseCase(this.repository);

  Future<List<Expense>> execute({
    int count = 10,
    FilterOptions filter = FilterOptions.allTime,
    int page = 1,
  }) {
    return repository.getRecentExpenses(
      count: count,
      filter: filter,
      page: page,
    );
  }
}
