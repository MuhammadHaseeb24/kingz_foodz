import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class _NotificationItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  const _NotificationItem(this.icon, this.title, this.subtitle, this.time);
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const _items = [
    _NotificationItem(Icons.delivery_dining_rounded, 'Order Delivered', 'Your order from King\'s Biryani House was delivered.', '2h ago'),
    _NotificationItem(Icons.local_offer_rounded, 'Flat 20% Off!', 'Get 20% off on your next order from Royal Burger Co.', '5h ago'),
    _NotificationItem(Icons.restaurant_rounded, 'Order Accepted', 'Palazzo Pizza has accepted your order and started preparing it.', '1d ago'),
    _NotificationItem(Icons.star_rounded, 'Rate your last order', 'How was your experience with Dragon Wok Chinese?', '2d ago'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final item = _items[i];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(color: AppColors.goldLight, shape: BoxShape.circle),
                  child: Icon(item.icon, color: AppColors.maroonDark, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 3),
                      Text(item.subtitle, style: const TextStyle(color: AppColors.grey, fontSize: 13)),
                      const SizedBox(height: 4),
                      Text(item.time, style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
