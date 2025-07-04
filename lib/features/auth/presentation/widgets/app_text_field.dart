import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool obscure;
  final Widget? suffixIcon;
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.obscure = false,
    this.suffixIcon,
  });
  @override
  Widget build(BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize:20,fontWeight:FontWeight.w600)),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 217, 227, 232),
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
            suffixIcon: suffixIcon,
            suffixIconColor: Colors.grey.shade400,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}
