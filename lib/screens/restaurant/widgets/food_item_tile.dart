import 'package:flutter/material.dart';
import '../../../models/food_item.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

class FoodItemTile extends StatelessWidget {
  final FoodItem item;
  final VoidCallback onAdd;

  const FoodItemTile({super.key, required this.item, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF0E8DC)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.isBestSeller)
                    Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: AppColors.goldLight, borderRadius: BorderRadius.circular(6)),
                      child: const Text('Best Seller', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                    ),
                  Text(item.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.grey, fontSize: 12.5, height: 1.3),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(Formatters.rupees(item.price),
                          style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.maroon)),
                      const SizedBox(width: 10),
                      const Icon(Icons.star_rounded, size: 14, color: AppColors.gold),
                      Text(' ${item.rating}', style: const TextStyle(fontSize: 12, color: AppColors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.image,
                    width: 88,
                    height: 88,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 88,
                      height: 88,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.fastfood_rounded, color: AppColors.grey),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  right: -6,
                  child: GestureDetector(
                    onTap: onAdd,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: AppColors.maroon, shape: BoxShape.circle),
                      child: const Icon(Icons.add_rounded, color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
