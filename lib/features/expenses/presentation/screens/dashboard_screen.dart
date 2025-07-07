import 'package:expense_tracker_app/features/expenses/presentation/cubit/dashboard_expenses_cuibt/expenses_cubit.dart';
import 'package:expense_tracker_app/features/expenses/presentation/cubit/dashboard_expenses_cuibt/expenses_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/dashboard/balance_card.dart';
import '../widgets/expenses/expense_list_item.dart';
import '../widgets/dashboard/header_deco_painter.dart';
import '../widgets/navigation/custom_bottom_nav_bar.dart'; // استورد هنا
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ExpensesCubit>().loadDashboard();
  }

  void _onTabSelected(int i) {
    setState(() => _selectedIndex = i);
    // هنا ممكن تعمل Navigation بين الصفحات لو حابب
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... فوق
bottomNavigationBar: CustomBottomNavBar(
  selectedIndex: _selectedIndex,
  onTabSelected: _onTabSelected,
  onPlusTap: () async {
    final added = await Navigator.pushNamed(context, '/add_expense_screen');
    if (added == true) {
      context.read<ExpensesCubit>().loadDashboard();
    }
  },
),
// ...

      // لا تضع FloatingActionButton هنا، لأنه أصبح في النافيجيشن بار

      body: BlocBuilder<ExpensesCubit, ExpensesState>(
        builder: (context, state) {
          if (state is ExpensesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ExpensesError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (state is ExpensesLoaded) {
            final expenses = state.expenses;
            final balance = state.balance;

            return Column(
              children: [
                // الهيدر مع شكل الدوائر الجديد
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Blue curved header
                    Container(
                      width: double.infinity,
                      height: 260,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF2F57E7), Color(0xFF2C50D1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10)),
                      ),
                    ),

                    // الدوائر الجديدة خلف الاسم مباشرة
                    Positioned(
                      top: 38,
                      left: 8,
                      child: SizedBox(
                        width: 170,
                        height: 90,
                        child: CustomPaint(
                          painter: HeaderDecoPainter(),
                        ),
                      ),
                    ),

                    // Greeting + filter dropdown
                    Positioned(
                      top: 48,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  AssetImage('assets/images/user.png'),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Good Morning',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white70,
                                        fontSize: 14)),
                                Text('Shihab Rahman',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ]),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(children: [
                              Text('This month',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              const Icon(Icons.keyboard_arrow_down_outlined,
                                  size: 20, color: Colors.black),
                            ]),
                          ),
                        ],
                      ),
                    ),

                    // Floating BalanceCard
                    Positioned(
                      bottom: -60,
                      left: 16,
                      right: 16,
                      child: BalanceCard(
                        totalBalance: balance.remainingBalanceUSD,
                        income: balance.totalIncomeUSD,
                        expenses: balance.totalExpensesUSD,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 88),
                // Recent Expenses title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Expenses',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'See all',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // List of recent expenses
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      return ExpenseListItem(expense: expenses[index]);
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
