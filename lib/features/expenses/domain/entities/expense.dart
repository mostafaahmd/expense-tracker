import 'package:flutter/material.dart';

class Expense {
  final String id;
  final String category;
  final IconData categoryIcon;
  final Color categoryColor;
  final bool isManual;
  final bool isExpense;
  final double amount;
  final String currency;        // رمز العملة الأصلية
  final double convertedAmount; // بعد التحويل إلى USD
  final DateTime date;
  final String? receiptImagePath;

  Expense({
    required this.id,
    required this.category,
    required this.categoryIcon,
    required this.categoryColor,
    required this.isManual,
    required this.isExpense,
    required this.amount,
    required this.currency,
    required this.convertedAmount,
    required this.date,
    this.receiptImagePath,
  });

  String get formattedDate {
    return '${date.month}/${date.day}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2,'0')}';
  }

  Expense copyWith({
    double? convertedAmount,
  }) {
    return Expense(
      id: id,
      category: category,
      categoryIcon: categoryIcon,
      categoryColor: categoryColor,
      isManual: isManual,
      isExpense: isExpense,
      amount: amount,
      currency: currency,
      convertedAmount: convertedAmount ?? this.convertedAmount,
      date: date,
      receiptImagePath: receiptImagePath,
    );
  }
}