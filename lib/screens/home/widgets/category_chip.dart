import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const CategoryChip({super.key, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.maroon : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: selected ? AppColors.maroon : Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.charcoal,
            fontWeight: FontWeight.w600,
            fontSize: 13.5,
          ),
        ),
      ),
    );
  }
}
