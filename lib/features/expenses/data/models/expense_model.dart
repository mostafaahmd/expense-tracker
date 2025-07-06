import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/expense.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 1)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String category;
  @HiveField(2)
  final int categoryIconCode;
  @HiveField(3)
  final int categoryColorValue;
  @HiveField(4)
  final bool isManual;
  @HiveField(5)
  final bool isExpense;
  @HiveField(6)
  final double amount;
  @HiveField(7)
  final String currency;
  @HiveField(8)
  final double convertedAmount;
  @HiveField(9)
  final DateTime date;
  @HiveField(10)
  final String? receiptImagePath;

  ExpenseModel({
    required this.id,
    required this.category,
    required this.categoryIconCode,
    required this.categoryColorValue,
    required this.isManual,
    required this.isExpense,
    required this.amount,
    required this.currency,
    required this.convertedAmount,
    required this.date,
    this.receiptImagePath,
  });

  factory ExpenseModel.fromEntity(Expense e) => ExpenseModel(
        id: e.id,
        category: e.category,
        categoryIconCode: e.categoryIcon.codePoint,
        categoryColorValue: e.categoryColor.value,
        isManual: e.isManual,
        isExpense: e.isExpense,
        amount: e.amount,
        currency: e.currency,
        convertedAmount: e.convertedAmount,
        date: e.date,
        receiptImagePath: e.receiptImagePath,
      );

  Expense toEntity() => Expense(
        id: id,
        category: category,
        categoryIcon: IconData(categoryIconCode, fontFamily: 'MaterialIcons'),
        categoryColor: Color(categoryColorValue),
        isManual: isManual,
        isExpense: isExpense,
        amount: amount,
        currency: currency,
        convertedAmount: convertedAmount,
        date: date,
        receiptImagePath: receiptImagePath,
      );
}