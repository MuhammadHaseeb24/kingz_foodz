enum OrderStatus {
  placed,
  accepted,
  preparing,
  riderAssigned,
  onTheWay,
  delivered,
  cancelled,
}

extension OrderStatusX on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.placed:
        return 'Order Placed';
      case OrderStatus.accepted:
        return 'Restaurant Accepted';
      case OrderStatus.preparing:
        return 'Preparing Your Food';
      case OrderStatus.riderAssigned:
        return 'Rider Assigned';
      case OrderStatus.onTheWay:
        return 'On The Way';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class FoodOrder {
  final String id;
  final String restaurantName;
  final String restaurantLogo;
  final List<String> itemSummaries;
  final double total;
  final DateTime placedAt;
  final OrderStatus status;
  final String riderName;

  const FoodOrder({
    required this.id,
    required this.restaurantName,
    required this.restaurantLogo,
    required this.itemSummaries,
    required this.total,
    required this.placedAt,
    required this.status,
    this.riderName = 'Ahmed Raza',
  });
}
