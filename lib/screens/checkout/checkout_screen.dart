import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_theme.dart';
import '../../utils/formatters.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _paymentMethod = 'Cash on Delivery';
  final _couponCtrl = TextEditingController();
  bool _placing = false;

  void _placeOrder() async {
    setState(() => _placing = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    final orderId = 'KF-${10000 + (DateTime.now().millisecondsSinceEpoch % 9000)}';
    context.read<CartProvider>().clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => OrderSuccessScreen(orderId: orderId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SectionCard(
            title: 'Delivery Address',
            icon: Icons.location_on_rounded,
            trailing: TextButton(onPressed: () {}, child: const Text('Change')),
            child: const Text(MockData.deliveryAddress, style: TextStyle(color: AppColors.grey)),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Payment Method',
            icon: Icons.payment_rounded,
            child: Column(
              children: [
                _PaymentTile(
                  label: 'Cash on Delivery',
                  icon: Icons.money_rounded,
                  selected: _paymentMethod == 'Cash on Delivery',
                  onTap: () => setState(() => _paymentMethod = 'Cash on Delivery'),
                ),
                _PaymentTile(
                  label: 'Debit / Credit Card',
                  icon: Icons.credit_card_rounded,
                  selected: _paymentMethod == 'Card',
                  onTap: () => setState(() => _paymentMethod = 'Card'),
                ),
                _PaymentTile(
                  label: 'JazzCash / Easypaisa',
                  icon: Icons.account_balance_wallet_rounded,
                  selected: _paymentMethod == 'Wallet',
                  onTap: () => setState(() => _paymentMethod = 'Wallet'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Coupon Code',
            icon: Icons.local_offer_rounded,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _couponCtrl,
                    decoration: const InputDecoration(hintText: 'Enter coupon code'),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Coupon applied (demo)')),
                    );
                  },
                  style: OutlinedButton.styleFrom(minimumSize: const Size(80, 48)),
                  child: const Text('Apply'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Order Summary',
            icon: Icons.receipt_long_rounded,
            child: Column(
              children: [
                _Row('Subtotal', cart.subtotal),
                _Row('Delivery Fee', cart.deliveryFee),
                _Row('Platform Fee', CartProvider.platformFee),
                const Divider(height: 20),
                _Row('Total Payable', cart.total, bold: true),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: _placing ? null : _placeOrder,
            child: _placing
                ? const SizedBox(
                    width: 22, height: 22,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.4),
                  )
                : Text('Place Order • ${Formatters.rupees(cart.total)}'),
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Widget? trailing;
  const _SectionCard({required this.title, required this.icon, required this.child, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: AppColors.maroon),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15))),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _PaymentTile({required this.label, required this.icon, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.charcoal),
            const SizedBox(width: 12),
            Expanded(child: Text(label)),
            Icon(
              selected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
              color: selected ? AppColors.maroon : AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final double value;
  final bool bold;
  const _Row(this.label, this.value, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
      fontSize: bold ? 16 : 14,
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
