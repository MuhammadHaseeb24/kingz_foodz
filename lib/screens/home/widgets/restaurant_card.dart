import 'package:flutter/material.dart';
import '../../../models/restaurant.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/formatters.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
    this.onFavoriteTap,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                  child: Image.network(
                    restaurant.coverImage,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 140,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.restaurant_rounded, size: 40, color: AppColors.grey),
                    ),
                  ),
                ),
                if (restaurant.isPromoted)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(8)),
                      child: const Text('Promoted', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                    ),
                  ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 16,
                      child: Icon(
                        isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        size: 16,
                        color: isFavorite ? AppColors.danger : AppColors.grey,
                      ),
                    ),
                  ),
                ),
                if (restaurant.offer.isNotEmpty)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      color: AppColors.maroonDark.withValues(alpha: 0.9),
                      child: Text(
                        restaurant.offer,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 3),
                  Text(restaurant.cuisine, style: const TextStyle(fontSize: 13, color: AppColors.grey)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 16, color: AppColors.gold),
                      const SizedBox(width: 3),
                      Text('${restaurant.rating}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      Text(' (${restaurant.reviewCount})', style: const TextStyle(color: AppColors.grey, fontSize: 12)),
                      const SizedBox(width: 12),
                      const Icon(Icons.location_on_outlined, size: 15, color: AppColors.grey),
                      const SizedBox(width: 2),
                      Text('${restaurant.distanceKm} km', style: const TextStyle(color: AppColors.grey, fontSize: 12)),
                      const SizedBox(width: 12),
                      const Icon(Icons.access_time_rounded, size: 15, color: AppColors.grey),
                      const SizedBox(width: 2),
                      Text('${restaurant.deliveryTimeMins} min', style: const TextStyle(color: AppColors.grey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    restaurant.deliveryFee == 0 ? 'Free Delivery' : '${Formatters.rupees(restaurant.deliveryFee)} delivery',
                    style: const TextStyle(color: AppColors.success, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
