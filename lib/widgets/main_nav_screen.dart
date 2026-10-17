import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../screens/home/home_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/orders/order_history_screen.dart';
import '../screens/favorites/favorites_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../theme/app_theme.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _index = 0;

  final _screens = const [
    HomeScreen(),
    SearchScreen(),
    OrderHistoryScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartProvider>().itemCount;
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Search'),
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: cartCount > 0,
              label: Text('$cartCount'),
              backgroundColor: AppColors.gold,
              textColor: AppColors.charcoal,
              child: const Icon(Icons.receipt_long_rounded),
            ),
            label: 'Orders',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.favorite_border_rounded), label: 'Favorites'),
          const BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}
