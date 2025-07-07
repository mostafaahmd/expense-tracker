import 'package:equatable/equatable.dart';

abstract class AddExpenseState extends Equatable {
  const AddExpenseState();

  @override
  List<Object?> get props => [];
}

class AddExpenseInitial extends AddExpenseState {}

class AddExpenseLoading extends AddExpenseState {}

class AddExpenseSuccess extends AddExpenseState {}

class AddExpenseError extends AddExpenseState {
  final String message;
  const AddExpenseError(this.message);

  @override
  List<Object?> get props => [message];
}
