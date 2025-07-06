import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IncomeExpenseColumn extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color color;
  final double amount;
  final String label;
  final Color textColor;

  const IncomeExpenseColumn({
    super.key,
    required this.icon,
    required this.background,
    required this.color,
    required this.amount,
    required this.label,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row: Icon + Text
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: background,
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        // Amount تحتهم
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
