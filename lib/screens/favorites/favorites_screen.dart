import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../providers/favorites_provider.dart';
import '../../theme/app_theme.dart';
import '../home/widgets/restaurant_card.dart';
import '../restaurant/restaurant_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    final list = favorites.favoritesFrom(MockData.restaurants);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: list.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border_rounded, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text('No favorites yet', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  const Text('Tap the heart icon on any restaurant to save it here',
                      style: TextStyle(color: AppColors.grey), textAlign: TextAlign.center),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: list
                  .map((r) => RestaurantCard(
                        restaurant: r,
                        isFavorite: true,
                        onFavoriteTap: () => favorites.toggle(r),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => RestaurantDetailScreen(restaurant: r)),
                        ),
                      ))
                  .toList(),
            ),
    );
  }
}
