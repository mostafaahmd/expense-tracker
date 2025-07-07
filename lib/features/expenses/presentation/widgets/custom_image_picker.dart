import 'package:expense_tracker_app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatelessWidget {
  final XFile? image;
  final VoidCallback onPick;

  const CustomImagePicker({super.key, required this.image, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        margin: const EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          color: AppColors.fieldFill,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              image != null ? "Image Selected" : "Upload image",
              style: TextStyle(
                color: image != null ? Colors.blue : Colors.grey[600],
              ),
            ),
            const Icon(Icons.camera_alt_outlined, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
