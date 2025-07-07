import 'package:flutter/material.dart';

class ExpenseCategory {
  final IconData icon;
  final String label;
  final Color color;
  final Color bg;
  final bool border;

  ExpenseCategory({
    required this.icon,
    required this.label,
    required this.color,
    required this.bg,
    this.border = false,
  });
}
