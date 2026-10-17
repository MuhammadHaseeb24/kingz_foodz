import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/main_nav_screen.dart';
import '../orders/order_tracking_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  final String orderId;
  const OrderSuccessScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 60),
              ),
              const SizedBox(height: 28),
              const Text('Order Placed!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(
                'Your order #$orderId has been placed successfully.\nThe restaurant is preparing your food.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.grey, height: 1.5),
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => OrderTrackingScreen(orderId: orderId)),
                    (route) => false,
                  ),
                  child: const Text('Track My Order'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MainNavScreen()),
                    (route) => false,
                  ),
                  child: const Text('Back to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
