import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/restaurant.dart';
import '../../providers/favorites_provider.dart';
import '../../theme/app_theme.dart';
import '../../utils/formatters.dart';
import '../cart/cart_screen.dart';
import '../../providers/cart_provider.dart';
import 'food_detail_sheet.dart';
import 'widgets/food_item_tile.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  String _activeCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final r = widget.restaurant;
    final favorites = context.watch<FavoritesProvider>();
    final categories = ['All', ...{for (final f in r.menu) f.category}];
    final menu = r.menu.where((f) => _activeCategory == 'All' || f.category == _activeCategory).toList();
    final cartCount = context.watch<CartProvider>().itemCount;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.maroon,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: Icon(
                  favorites.isFavorite(r) ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: favorites.isFavorite(r) ? AppColors.danger : Colors.white,
                ),
                onPressed: () => favorites.toggle(r),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                r.coverImage,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: AppColors.maroon),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              transform: Matrix4.translationValues(0, -20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(r.cuisine, style: const TextStyle(color: AppColors.grey)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _InfoChip(icon: Icons.star_rounded, label: '${r.rating} (${r.reviewCount})', color: AppColors.gold),
                      const SizedBox(width: 10),
                      _InfoChip(icon: Icons.access_time_rounded, label: '${r.deliveryTimeMins} min'),
                      const SizedBox(width: 10),
                      _InfoChip(icon: Icons.location_on_outlined, label: '${r.distanceKm} km'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    r.deliveryFee == 0 ? 'Free delivery' : '${Formatters.rupees(r.deliveryFee)} delivery fee',
                    style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  if (r.offer.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(color: AppColors.goldLight, borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          const Icon(Icons.local_offer_rounded, size: 18, color: AppColors.maroonDark),
                          const SizedBox(width: 8),
                          Text(r.offer, style: const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final cat = categories[i];
                  final selected = cat == _activeCategory;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: selected,
                    onSelected: (_) => setState(() => _activeCategory = cat),
                    selectedColor: AppColors.maroon,
                    labelStyle: TextStyle(color: selected ? Colors.white : AppColors.charcoal, fontWeight: FontWeight.w600),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final item = menu[i];
                return FoodItemTile(
                  item: item,
                  onAdd: () => showFoodDetailSheet(context, item: item, restaurant: r),
                );
              },
              childCount: menu.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: cartCount > 0
          ? FloatingActionButton.extended(
              backgroundColor: AppColors.maroon,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CartScreen()),
              ),
              icon: const Icon(Icons.shopping_bag_rounded, color: Colors.white),
              label: Text('View Cart ($cartCount)', style: const TextStyle(color: Colors.white)),
            )
          : null,
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  const _InfoChip({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color ?? AppColors.grey),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
