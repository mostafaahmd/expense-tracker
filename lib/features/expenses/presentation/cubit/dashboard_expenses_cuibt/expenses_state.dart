import 'package:equatable/equatable.dart';
import 'package:expense_tracker_app/features/expenses/domain/entities/balance.dart';
import 'package:expense_tracker_app/features/expenses/domain/entities/expense.dart';


abstract class ExpensesState extends Equatable {
  const ExpensesState();

  @override
  List<Object?> get props => [];
}

class ExpensesInitial extends ExpensesState {
  const ExpensesInitial();
}

class ExpensesLoading extends ExpensesState {
  const ExpensesLoading();
}

class ExpensesLoaded extends ExpensesState {
  final List<Expense> expenses;
  final Balance balance;

  const ExpensesLoaded({
    required this.expenses,
    required this.balance,
  });

  @override
  List<Object?> get props => [expenses, balance];
}

class ExpensesError extends ExpensesState {
  final String message;

  const ExpensesError(this.message);

  @override
  List<Object?> get props => [message];
}
