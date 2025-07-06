// lib/features/expenses/domain/entities/balance.dart

class Balance {
  final double totalIncomeUSD;
  final double totalExpensesUSD;

  Balance({
    required this.totalIncomeUSD,
    required this.totalExpensesUSD,
  });

  double get remainingBalanceUSD => totalIncomeUSD - totalExpensesUSD;
}
