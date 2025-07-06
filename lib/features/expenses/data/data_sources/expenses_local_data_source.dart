import 'package:expense_tracker_app/features/expenses/domain/repo_interface/expenses_repository.dart';
import 'package:hive/hive.dart';
import '../models/expense_model.dart';

abstract class ExpensesLocalDataSource {
  Future<List<ExpenseModel>> getExpenses({
    required int page,
    required int count,
    required FilterOptions filter,
  });
  Future<void> cacheExpense(ExpenseModel model);
  Future<double> getTotalIncome();
  Future<double> getTotalExpenses();
}

class ExpensesLocalDataSourceImpl implements ExpensesLocalDataSource {
  final Box<ExpenseModel> box;

  ExpensesLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheExpense(ExpenseModel model) async {
    await box.put(model.id, model);
  }

  @override
  Future<List<ExpenseModel>> getExpenses({
    required int page,
    required int count,
    required FilterOptions filter,
  }) async {
    final all = box.values.toList();
    // TODO: apply FilterOptions logic here
    return all.skip((page - 1) * count).take(count).toList();
  }

  @override
  Future<double> getTotalIncome() async {
    return box.values
      .where((m) => !m.isExpense)
      .fold<double>(0.0, (sum, m) => sum + m.convertedAmount);
  }

  @override
  Future<double> getTotalExpenses() async {
    return box.values
      .where((m) => m.isExpense)
      .fold<double>(0.0, (sum, m) => sum + m.convertedAmount);
  }
}