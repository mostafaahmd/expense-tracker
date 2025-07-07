import 'package:expense_tracker_app/core/constants/colors.dart';
import 'package:expense_tracker_app/features/expenses/data/models/expense_category.dart';
import 'package:expense_tracker_app/features/expenses/presentation/widgets/shared/custom_drop_down.dart';
import 'package:expense_tracker_app/features/expenses/presentation/widgets/shared/custom_form_field.dart';
import 'package:expense_tracker_app/features/expenses/presentation/widgets/shared/custom_image_picker.dart';
import 'package:expense_tracker_app/features/expenses/domain/entities/expense.dart';
import 'package:expense_tracker_app/features/expenses/presentation/cubit/add_expenses_cubit/add_expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  DateTime? date = DateTime.now();
  XFile? receiptImage;

  final currencies = ["USD", "EGP", "EUR", "SAR", "GBP"];
  String selectedCurrency = "USD";

  final List<ExpenseCategory> categories = [
    ExpenseCategory(
      icon: Icons.shopping_cart,
      label: "Groceries",
      color: Color(0xFF4DB7FF),
      bg: Color(0xFFEDF7FF),
    ),
    ExpenseCategory(
      icon: Icons.local_activity,
      label: "Entertainment",
      color: Color(0xFF356DFF),
      bg: Color(0xFFEAF0FF),
    ),
    ExpenseCategory(
      icon: Icons.local_gas_station,
      label: "Gas",
      color: Color(0xFFFF7694),
      bg: Color(0xFFFFEEF1),
    ),
    ExpenseCategory(
      icon: Icons.shopping_bag,
      label: "Shopping",
      color: Color(0xFFFFC542),
      bg: Color(0xFFFFF7E4),
    ),
    ExpenseCategory(
      icon: Icons.newspaper,
      label: "News Paper",
      color: Color(0xFFF59C1A),
      bg: Color(0xFFFFF6E2),
    ),
    ExpenseCategory(
      icon: Icons.directions_car,
      label: "Transport",
      color: Color(0xFF7F63F4),
      bg: Color(0xFFEDEAFF),
    ),
    ExpenseCategory(
      icon: Icons.home,
      label: "Rent",
      color: Color(0xFFFFA981),
      bg: Color(0xFFFFF2EC),
    ),
    ExpenseCategory(
      icon: Icons.add,
      label: "Add Category",
      color: Color(0xFF356DFF),
      bg: Colors.transparent,
      border: true,
    ),
  ];
  ExpenseCategory? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = categories[1];
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => receiptImage = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Add Expense",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Categories", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 10),
              CustomDropdown<ExpenseCategory>(
                value: selectedCategory,
                items: categories.map((cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Row(
                      children: [
                        Icon(cat.icon, color: cat.color, size: 20),
                        const SizedBox(width: 10),
                        Text(cat.label),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (val) => setState(() => selectedCategory = val),
                validator: (val) => val == null ? "Select a category" : null,
                hint: "Select category",
              ),
              const SizedBox(height: 18),

              Text("Currency", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 10),
              CustomDropdown<String>(
                value: selectedCurrency,
                items: currencies
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => selectedCurrency = v ?? "USD"),
                validator: (val) => val == null || val.isEmpty ? "Select currency" : null,
                hint: "Select currency",
              ),
              const SizedBox(height: 18),

              Text("Amount", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 10),
              CustomFormField(
                hint: "\$50,000",
                controller: _amountController,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Enter amount";
                  final parsed = double.tryParse(v);
                  if (parsed == null || parsed <= 0) return "Enter a valid amount";
                  return null;
                },
              ),
              const SizedBox(height: 18),

              Text("Date", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 10),
              CustomFormField(
                hint: date != null
                    ? "${date!.month}/${date!.day}/${date!.year}"
                    : "02/01/24",
                readOnly: true,
                suffixIcon: const Icon(Icons.calendar_today_rounded),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: date ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => date = picked);
                },
              ),
              const SizedBox(height: 18),

              Text("Attach Receipt", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 10),
              CustomImagePicker(
                image: receiptImage,
                onPick: _pickImage,
              ),
              const SizedBox(height: 18),

              Text("Categories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                mainAxisSpacing: 18,
                crossAxisSpacing: 8,
                childAspectRatio: 0.8,
                physics: const NeverScrollableScrollPhysics(),
                children: categories.map((cat) {
                  final isSelected = selectedCategory?.label == cat.label;
                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = cat),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? cat.color
                                : cat.bg,
                            borderRadius: BorderRadius.circular(28),
                            border: cat.border
                                ? Border.all(color: cat.color, width: 2)
                                : null,
                          ),
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              cat.icon,
                              color: isSelected
                                  ? Colors.white
                                  : cat.color,
                              size: 26,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          cat.label,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected
                                ? cat.color
                                : Colors.black,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final expense = Expense(
                        id: UniqueKey().toString(),
                        category: selectedCategory?.label ?? "",
                        categoryIcon: selectedCategory?.icon ?? Icons.help_outline,
                        categoryColor: selectedCategory?.color ?? Colors.blue,
                        isManual: true,
                        isExpense: true,
                        amount: double.tryParse(_amountController.text) ?? 0,
                        currency: selectedCurrency,
                        convertedAmount: double.tryParse(_amountController.text) ?? 0, // سيتم الحساب بالدولار في الريبو
                        date: date ?? DateTime.now(),
                        receiptImagePath: receiptImage?.path,
                      );
                      await context.read<AddExpenseCubit>().submitExpense(expense);
                      Navigator.pop(context, true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
