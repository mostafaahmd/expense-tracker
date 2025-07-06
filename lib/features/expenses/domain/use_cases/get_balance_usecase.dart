// lib/features/expenses/domain/use_cases/get_balance_usecase.dart

import 'package:expense_tracker_app/features/expenses/domain/repo_interface/expenses_repository.dart';

import '../entities/balance.dart';

class GetBalanceUseCase {
  final ExpensesRepository repository;

  GetBalanceUseCase(this.repository);

  Future<Balance> execute({
    FilterOptions filter = FilterOptions.allTime,
  }) {
    return repository.getBalance(filter: filter);
  }
}
