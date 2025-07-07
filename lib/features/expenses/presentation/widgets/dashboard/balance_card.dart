import 'package:expense_tracker_app/features/expenses/presentation/widgets/dashboard/card_deco_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'income_expense_column.dart';

class BalanceCard extends StatelessWidget {
  final double totalBalance;
  final double income;
  final double expenses;

  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.income,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(73, 111, 241, 1),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Stack(
        children: [
          // الرسم الزخرفي (دوائر مجوفة)
          Positioned.fill(
            child: CustomPaint(
              painter: CardDecorationPainter(),
            ),
          ),
          // محتوى الكارد فوق الرسم
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total Balance',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_up_outlined, color: Colors.white),
                      ],
                    ),
                    const Icon(Icons.more_horiz, color: Colors.white70),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${totalBalance.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IncomeExpenseColumn(
                      icon: Icons.arrow_downward,
                      background: const Color.fromARGB(255, 91, 136, 227),
                      color: Colors.white,
                      amount: income,
                      label: 'Income',
                      textColor: Colors.white,
                    ),
                    IncomeExpenseColumn(
                      icon: Icons.arrow_upward,
                      background: const Color.fromARGB(255, 91, 136, 227),
                      color: Colors.white,
                      amount: expenses,
                      label: 'Expenses',
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'income_expense_column.dart';

// class BalanceCard extends StatelessWidget {
//   final double totalBalance;
//   final double income;
//   final double expenses;

//   const BalanceCard({
//     super.key,
//     required this.totalBalance,
//     required this.income,
//     required this.expenses,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color.fromRGBO(73, 111, 241, 1),
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//           bottomLeft: Radius.circular(20),
//           bottomRight: Radius.circular(20),
//         ),
//         boxShadow: const [
//           BoxShadow(
//               color: Colors.black26, blurRadius: 12, offset: Offset(0, 4))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Row(
//               children: [
//                 Text('Total Balance',
//                     style: GoogleFonts.poppins(color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 20,)),
//                 Icon(Icons.keyboard_arrow_up_outlined,
//                 color: Colors.white,)    
//               ],
//             ),
//             const Icon(Icons.more_horiz, color: Colors.white70),
//           ]),
//           const SizedBox(height: 8),
//           Text('\$${totalBalance.toStringAsFixed(2)}',
//               style: GoogleFonts.poppins(
//                   fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white)),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IncomeExpenseColumn(
//                 icon: Icons.arrow_downward,
//                 background: const Color.fromARGB(255, 91, 136, 227),
//                 color: Colors.white,
//                 amount: income,
//                 label: 'Income',
//                 textColor: Colors.white,
//               ),
//               IncomeExpenseColumn(
//                 icon: Icons.arrow_upward,
//                 background: Color.fromARGB(255, 91, 136, 227),
//                 color: Colors.white,
//                 amount: expenses,
//                 label: 'Expenses',
//                 textColor: Colors.white,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
