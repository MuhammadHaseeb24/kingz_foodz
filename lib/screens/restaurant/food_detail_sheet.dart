import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/food_item.dart';
import '../../models/restaurant.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_theme.dart';
import '../../utils/formatters.dart';

Future<void> showFoodDetailSheet(
  BuildContext context, {
  required FoodItem item,
  required Restaurant restaurant,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => FoodDetailSheet(item: item, restaurant: restaurant),
  );
}

class FoodDetailSheet extends StatefulWidget {
  final FoodItem item;
  final Restaurant restaurant;
  const FoodDetailSheet({super.key, required this.item, required this.restaurant});

  @override
  State<FoodDetailSheet> createState() => _FoodDetailSheetState();
}

class _FoodDetailSheetState extends State<FoodDetailSheet> {
  int _quantity = 1;
  final Set<String> _selectedAddOns = {};
  final _instructionsCtrl = TextEditingController();

  double get _addOnsTotal => _selectedAddOns.length * 100.0;
  double get _total => (widget.item.price + _addOnsTotal) * _quantity;

  @override
  void dispose() {
    _instructionsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.cream,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4)),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                      child: Image.network(
                        item.image,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 200,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.fastfood_rounded, size: 48, color: AppColors.grey),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 6),
                          Text(item.description, style: const TextStyle(color: AppColors.grey, height: 1.4)),
                          const SizedBox(height: 10),
                          Text(Formatters.rupees(item.price),
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.maroon)),
                          if (item.addOns.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            const Text('Add-ons', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                            const SizedBox(height: 8),
                            ...item.addOns.map((addOn) => CheckboxListTile(
                                  value: _selectedAddOns.contains(addOn),
                                  onChanged: (v) => setState(() {
                                    if (v == true) {
                                      _selectedAddOns.add(addOn);
                                    } else {
                                      _selectedAddOns.remove(addOn);
                                    }
                                  }),
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: AppColors.maroon,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  title: Text(addOn),
                                  secondary: const Text('+ Rs. 100', style: TextStyle(color: AppColors.grey, fontSize: 13)),
                                )),
                          ],
                          const SizedBox(height: 20),
                          const Text('Special Instructions', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _instructionsCtrl,
                            maxLines: 2,
                            decoration: const InputDecoration(hintText: 'e.g. less spicy, no onions...'),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              const Text('Quantity', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                              const Spacer(),
                              _QtyButton(
                                icon: Icons.remove_rounded,
                                onTap: () => setState(() => _quantity = _quantity > 1 ? _quantity - 1 : 1),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text('$_quantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                              ),
                              _QtyButton(icon: Icons.add_rounded, onTap: () => setState(() => _quantity++)),
                            ],
                          ),
                          const SizedBox(height: 90),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CartProvider>().addItem(
                            item,
                            widget.restaurant,
                            quantity: _quantity,
                            addOns: _selectedAddOns.toList(),
                            instructions: _instructionsCtrl.text.trim(),
                          );
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${item.name} added to cart'), duration: const Duration(seconds: 1)),
                      );
                    },
                    child: Text('Add to Cart • ${Formatters.rupees(_total)}'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 18, color: AppColors.maroon),
      ),
    );
  }
}
