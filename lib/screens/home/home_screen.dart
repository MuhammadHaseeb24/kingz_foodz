import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../providers/favorites_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/section_header.dart';
import '../ai/ai_assistant_screen.dart';
import '../notifications/notifications_screen.dart';
import '../restaurant/restaurant_detail_screen.dart';
import '../search/search_screen.dart';
import 'widgets/category_chip.dart';
import 'widgets/restaurant_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    final restaurants = MockData.restaurants.where((r) {
      if (_selectedCategory == 'All') return true;
      return r.menu.any((f) => f.category == _selectedCategory);
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: _buildSearchBar(context)),
            SliverToBoxAdapter(child: _buildAiBanner(context)),
            SliverToBoxAdapter(child: _buildCategories()),
            SliverToBoxAdapter(
              child: SectionHeader(
                title: _selectedCategory == 'All' ? 'Nearby Restaurants' : _selectedCategory,
                actionLabel: 'See all',
                onAction: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SearchScreen()),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final r = restaurants[i];
                  return RestaurantCard(
                    restaurant: r,
                    isFavorite: favorites.isFavorite(r),
                    onFavoriteTap: () => favorites.toggle(r),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => RestaurantDetailScreen(restaurant: r)),
                    ),
                  );
                },
                childCount: restaurants.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        children: [
          const Icon(Icons.location_on_rounded, color: AppColors.maroon, size: 20),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Deliver to', style: TextStyle(fontSize: 11, color: AppColors.grey)),
                Text(
                  MockData.deliveryAddress,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            ),
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none_rounded, color: AppColors.charcoal),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(color: AppColors.danger, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const SearchScreen()),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE7DCD0)),
          ),
          child: const Row(
            children: [
              Icon(Icons.search_rounded, color: AppColors.grey),
              SizedBox(width: 10),
              Text('Search restaurants or dishes...', style: TextStyle(color: AppColors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAiBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AiAssistantScreen()),
        ),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.maroon, AppColors.maroonDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
                child: const Icon(Icons.auto_awesome_rounded, color: AppColors.maroonDark),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ask the AI Food Assistant',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                    SizedBox(height: 2),
                    Text('"Spicy biryani under Rs.700 near me"',
                        style: TextStyle(color: Colors.white70, fontSize: 12.5)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        itemCount: MockData.categories.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final label = i == 0 ? 'All' : MockData.categories[i - 1];
          return CategoryChip(
            label: label,
            selected: _selectedCategory == label,
            onTap: () => setState(() => _selectedCategory = label),
          );
        },
      ),
    );
  }
}
