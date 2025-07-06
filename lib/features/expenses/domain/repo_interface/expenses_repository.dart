// lib/features/expenses/domain/repo_interfaces/expenses_repository.dart

import '../entities/expense.dart';
import '../entities/balance.dart';

enum FilterOptions { thisMonth, last7Days, allTime }

abstract class ExpensesRepository {
  Future<List<Expense>> getRecentExpenses({
    int count = 10,
    FilterOptions filter = FilterOptions.allTime,
    int page = 1,
  });

  Future<Balance> getBalance({
    FilterOptions filter = FilterOptions.allTime,
  });

  Future<void> addExpense(Expense expense);
}
