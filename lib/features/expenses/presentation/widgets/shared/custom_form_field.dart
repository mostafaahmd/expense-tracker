import 'package:expense_tracker_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomFormField({
    super.key,
    this.hint,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.fieldFill,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
