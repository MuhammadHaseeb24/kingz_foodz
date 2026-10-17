import 'food_item.dart';

class Restaurant {
  final String id;
  final String name;
  final String cuisine;
  final String coverImage;
  final String logo;
  final double rating;
  final int reviewCount;
  final double distanceKm;
  final int deliveryTimeMins;
  final double deliveryFee;
  final bool isPromoted;
  final String offer;
  final List<FoodItem> menu;

  const Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.coverImage,
    required this.logo,
    required this.rating,
    required this.reviewCount,
    required this.distanceKm,
    required this.deliveryTimeMins,
    required this.deliveryFee,
    this.isPromoted = false,
    this.offer = '',
    this.menu = const [],
  });
}
