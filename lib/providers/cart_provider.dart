import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/food_item.dart';
import '../models/restaurant.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  static const double taxRate = 0.0; // set if applicable
  static const double platformFee = 25;

  List<CartItem> get items => List.unmodifiable(_items);
  bool get isEmpty => _items.isEmpty;
  int get itemCount => _items.fold(0, (sum, i) => sum + i.quantity);

  Restaurant? get currentRestaurant =>
      _items.isEmpty ? null : _items.first.restaurant;

  double get subtotal => _items.fold(0, (sum, i) => sum + i.lineTotal);
  double get deliveryFee => _items.isEmpty ? 0 : currentRestaurant!.deliveryFee;
  double get tax => subtotal * taxRate;
  double get total => subtotal + deliveryFee + tax + platformFee;

  /// Adding from a different restaurant clears the cart first (common
  /// food-delivery UX — one active restaurant per cart).
  void addItem(
    FoodItem food,
    Restaurant restaurant, {
    int quantity = 1,
    List<String> addOns = const [],
    String instructions = '',
  }) {
    if (_items.isNotEmpty && _items.first.restaurant.id != restaurant.id) {
      _items.clear();
    }
    final existingIndex = _items.indexWhere((i) =>
        i.food.id == food.id &&
        listEquals(i.selectedAddOns, addOns) &&
        i.specialInstructions == instructions);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(
        food: food,
        restaurant: restaurant,
        quantity: quantity,
        selectedAddOns: addOns,
        specialInstructions: instructions,
      ));
    }
    notifyListeners();
  }

  void increment(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decrement(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
