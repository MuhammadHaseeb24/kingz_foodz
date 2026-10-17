class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;
  final double rating;
  final bool isBestSeller;
  final bool isVeg;
  final List<String> addOns;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    this.rating = 4.5,
    this.isBestSeller = false,
    this.isVeg = false,
    this.addOns = const [],
  });
}
