import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/expense.dart';
import 'package:intl/intl.dart';


class ExpenseListItem extends StatelessWidget {
  final Expense expense;

  const ExpenseListItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(
          color: Colors.black12, blurRadius: 8, offset: Offset(0,2)
        )],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: expense.categoryColor.withOpacity(0.2),
            child: Icon(expense.categoryIcon, color: expense.categoryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(expense.category,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(expense.isManual ? 'Manually' : 'Auto',
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${expense.isExpense ? '-' : '+'}\$${expense.convertedAmount.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
              const SizedBox(height: 4),
              Text(DateFormat('MMM dd, hh:mm a').format(expense.date),
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
