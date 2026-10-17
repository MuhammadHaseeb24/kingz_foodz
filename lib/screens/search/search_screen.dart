import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../models/food_item.dart';
import '../../models/restaurant.dart';
import '../../theme/app_theme.dart';
import '../home/widgets/restaurant_card.dart';
import '../restaurant/restaurant_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/favorites_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';
  String _sortBy = 'Relevance';

  List<Restaurant> get _results {
    var list = MockData.restaurants.where((r) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return r.name.toLowerCase().contains(q) ||
          r.cuisine.toLowerCase().contains(q) ||
          r.menu.any((f) => f.name.toLowerCase().contains(q));
    }).toList();

    switch (_sortBy) {
      case 'Rating':
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Distance':
        list.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
        break;
      case 'Delivery Time':
        list.sort((a, b) => a.deliveryTimeMins.compareTo(b.deliveryTimeMins));
        break;
    }
    return list;
  }

  List<FoodItem> get _matchingDishes {
    if (_query.isEmpty) return [];
    final q = _query.toLowerCase();
    return MockData.allFoodItems.where((f) => f.name.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: TextField(
              controller: _controller,
              autofocus: false,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Search restaurants, dishes, cuisines...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.mic_none_rounded),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Voice search (demo)')),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: ['Relevance', 'Rating', 'Distance', 'Delivery Time']
                  .map((s) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(s),
                          selected: _sortBy == s,
                          onSelected: (_) => setState(() => _sortBy = s),
                          selectedColor: AppColors.maroon,
                          labelStyle: TextStyle(
                            color: _sortBy == s ? Colors.white : AppColors.charcoal,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.5,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _results.isEmpty
                ? const Center(
                    child: Text('No restaurants match your search', style: TextStyle(color: AppColors.grey)),
                  )
                : ListView(
                    padding: const EdgeInsets.only(top: 4, bottom: 20),
                    children: [
                      if (_matchingDishes.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                          child: Text('Dishes matching "$_query"',
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                        ),
                        ..._matchingDishes.map((f) => ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(f.image, width: 48, height: 48, fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(width: 48, height: 48, color: Colors.grey.shade200)),
                              ),
                              title: Text(f.name),
                              subtitle: Text('Rs. ${f.price.toStringAsFixed(0)}'),
                            )),
                        const Divider(height: 24),
                      ],
                      ..._results.map((r) => RestaurantCard(
                            restaurant: r,
                            isFavorite: favorites.isFavorite(r),
                            onFavoriteTap: () => favorites.toggle(r),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => RestaurantDetailScreen(restaurant: r)),
                            ),
                          )),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
