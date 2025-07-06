import 'package:expense_tracker_app/features/expenses/data/data_sources/currenct_api_service.dart';
import 'package:expense_tracker_app/features/expenses/domain/repo_interface/expenses_repository.dart';

import '../../domain/entities/expense.dart';
import '../../domain/entities/balance.dart';
import '../data_sources/expenses_local_data_source.dart';
import '../models/expense_model.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  final ExpensesLocalDataSource localDS;
  final CurrencyApiService apiService;

  ExpensesRepositoryImpl(this.localDS, this.apiService);

  @override
  Future<void> addExpense(Expense expense) async {
    final rate = await apiService.fetchRate(expense.currency, 'USD');
    final converted = expense.amount * rate;
    final model = ExpenseModel.fromEntity(expense.copyWith(convertedAmount: converted));
    await localDS.cacheExpense(model);
  }

  @override
  Future<Balance> getBalance({FilterOptions filter = FilterOptions.allTime}) async {
    final income = await localDS.getTotalIncome();
    final expenses = await localDS.getTotalExpenses();
    return Balance(totalIncomeUSD: income, totalExpensesUSD: expenses);
  }

  @override
  Future<List<Expense>> getRecentExpenses({int count = 10, FilterOptions filter = FilterOptions.allTime, int page = 1}) async {
    final models = await localDS.getExpenses(page: page, count: count, filter: filter);
    return models.map((m) => m.toEntity()).toList();
  }
}