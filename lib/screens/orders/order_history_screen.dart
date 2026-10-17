import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/mock_data.dart';
import '../../models/order.dart';
import '../../theme/app_theme.dart';
import '../../utils/formatters.dart';
import 'order_tracking_screen.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = MockData.pastOrders;
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: orders.isEmpty
          ? const Center(child: Text('No orders yet', style: TextStyle(color: AppColors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: orders.length,
              itemBuilder: (context, i) {
                final order = orders[i];
                final color = order.status == OrderStatus.delivered
                    ? AppColors.success
                    : order.status == OrderStatus.cancelled
                        ? AppColors.danger
                        : AppColors.maroon;
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(order.restaurantLogo, width: 46, height: 46, fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(width: 46, height: 46, color: Colors.grey.shade200)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(order.restaurantName, style: const TextStyle(fontWeight: FontWeight.w700)),
                                Text(
                                  DateFormat('MMM d, h:mm a').format(order.placedAt),
                                  style: const TextStyle(color: AppColors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
                            child: Text(order.status.label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      const Divider(height: 22),
                      Text(order.itemSummaries.join(' • '), style: const TextStyle(color: AppColors.grey, fontSize: 13)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Formatters.rupees(order.total), style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.maroon)),
                          Row(
                            children: [
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(minimumSize: const Size(70, 36), padding: const EdgeInsets.symmetric(horizontal: 12)),
                                child: const Text('Reorder', style: TextStyle(fontSize: 12)),
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => OrderTrackingScreen(orderId: order.id)),
                                ),
                                child: const Text('Track', style: TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
