import 'food_item.dart';
import 'restaurant.dart';

class CartItem {
  final FoodItem food;
  final Restaurant restaurant;
  int quantity;
  final List<String> selectedAddOns;
  final String specialInstructions;

  CartItem({
    required this.food,
    required this.restaurant,
    this.quantity = 1,
    this.selectedAddOns = const [],
    this.specialInstructions = '',
  });

  double get addOnsTotal => selectedAddOns.length * 100.0;
  double get lineTotal => (food.price + addOnsTotal) * quantity;
}
