import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../theme/app_theme.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;
  const OrderTrackingScreen({super.key, required this.orderId});

  static const _steps = [
    OrderStatus.placed,
    OrderStatus.accepted,
    OrderStatus.preparing,
    OrderStatus.riderAssigned,
    OrderStatus.onTheWay,
    OrderStatus.delivered,
  ];

  @override
  Widget build(BuildContext context) {
    const currentIndex = 3; // demo: rider assigned

    return Scaffold(
      appBar: AppBar(title: Text('Order $orderId')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFFEDE3D6),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.map_rounded, size: 64, color: Colors.grey.shade400),
                Positioned(
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delivery_dining_rounded, size: 18, color: AppColors.maroon),
                        SizedBox(width: 6),
                        Text('Live map preview', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                const CircleAvatar(radius: 26, backgroundColor: AppColors.goldLight, child: Icon(Icons.person, color: AppColors.maroon)),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ahmed Raza', style: TextStyle(fontWeight: FontWeight.w700)),
                      Text('Your delivery rider', style: TextStyle(color: AppColors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                _RoundIconButton(icon: Icons.call_rounded, onTap: () {}),
                const SizedBox(width: 10),
                _RoundIconButton(icon: Icons.message_rounded, onTap: () {}),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Order Status', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 12),
          ..._steps.asMap().entries.map((entry) {
            final i = entry.key;
            final step = entry.value;
            final done = i <= currentIndex;
            final isLast = i == _steps.length - 1;
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: done ? AppColors.maroon : Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: done ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
                      ),
                      if (!isLast)
                        Expanded(
                          child: Container(width: 2, color: done ? AppColors.maroon : Colors.grey.shade300),
                        ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        step.label,
                        style: TextStyle(
                          fontWeight: done ? FontWeight.w700 : FontWeight.w500,
                          color: done ? AppColors.charcoal : AppColors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _RoundIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(color: AppColors.cream, shape: BoxShape.circle),
        child: Icon(icon, size: 18, color: AppColors.maroon),
      ),
    );
  }
}
