import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_theme.dart';
import '../../utils/formatters.dart';
import '../checkout/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: cart.isEmpty
          ? const _EmptyCart()
          : Column(
              children: [
                if (cart.currentRestaurant != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: Row(
                      children: [
                        const Icon(Icons.storefront_rounded, size: 18, color: AppColors.maroon),
                        const SizedBox(width: 8),
                        Text(cart.currentRestaurant!.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: cart.items.length,
                    itemBuilder: (context, i) {
                      final item = cart.items[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFF0E8DC)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(item.food.image, width: 64, height: 64, fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(width: 64, height: 64, color: Colors.grey.shade200)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.food.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                                  if (item.selectedAddOns.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text('+ ${item.selectedAddOns.join(', ')}',
                                          style: const TextStyle(fontSize: 12, color: AppColors.grey)),
                                    ),
                                  const SizedBox(height: 6),
                                  Text(Formatters.rupees(item.lineTotal),
                                      style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.maroon)),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.grey),
                                  onPressed: () => context.read<CartProvider>().removeItem(item),
                                ),
                                Row(
                                  children: [
                                    _StepBtn(icon: Icons.remove, onTap: () => context.read<CartProvider>().decrement(item)),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.w700)),
                                    ),
                                    _StepBtn(icon: Icons.add, onTap: () => context.read<CartProvider>().increment(item)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, -4))],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        _SummaryRow('Subtotal', cart.subtotal),
                        _SummaryRow('Delivery Fee', cart.deliveryFee),
                        _SummaryRow('Platform Fee', CartProvider.platformFee),
                        const Divider(height: 20),
                        _SummaryRow('Total', cart.total, bold: true),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                            ),
                            child: const Text('Proceed to Checkout'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool bold;
  const _SummaryRow(this.label, this.value, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
      fontSize: bold ? 17 : 14,
      color: bold ? AppColors.charcoal : AppColors.grey,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(Formatters.rupees(value), style: style.copyWith(color: bold ? AppColors.maroon : AppColors.charcoal)),
        ],
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _StepBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)),
        child: Icon(icon, size: 14, color: AppColors.maroon),
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 72, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text('Your cart is empty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          const Text('Add some delicious food to get started', style: TextStyle(color: AppColors.grey)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(minimumSize: const Size(200, 48)),
            child: const Text('Browse Restaurants'),
          ),
        ],
      ),
    );
  }
}
