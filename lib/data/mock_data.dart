import '../models/food_item.dart';
import '../models/restaurant.dart';
import '../models/order.dart';

/// Static/mock data used across the app. Replace with real API / Firestore
/// calls once the backend is wired up.
class MockData {
  static const String userName = 'Haseeb';
  static const String userEmail = 'demo@kingsfoodz.com';
  static const String userPhone = '+92 300 1234567';
  static const String deliveryAddress = 'House 12, Street 4, Bahria Town, Rawalpindi';

  static const List<String> categories = [
    'Biryani',
    'Burgers',
    'Pizza',
    'BBQ',
    'Chinese',
    'Desserts',
    'Fast Food',
    'Drinks',
  ];

  static final List<Restaurant> restaurants = [
    Restaurant(
      id: 'r1',
      name: "King's Biryani House",
      cuisine: 'Biryani • Pakistani',
      coverImage:
          'https://images.unsplash.com/photo-1563379091339-03246963d96c?w=800',
      logo: 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=200',
      rating: 4.7,
      reviewCount: 2140,
      distanceKm: 1.2,
      deliveryTimeMins: 28,
      deliveryFee: 99,
      isPromoted: true,
      offer: '20% OFF up to Rs.300',
      menu: [
        FoodItem(
          id: 'f1',
          name: 'Chicken Biryani (Full)',
          description: 'Fragrant basmati rice slow-cooked with tender chicken and royal spices.',
          price: 650,
          image: 'https://images.unsplash.com/photo-1633945274405-b6c8069047b0?w=600',
          category: 'Biryani',
          rating: 4.8,
          isBestSeller: true,
          addOns: const ['Extra Raita', 'Boiled Egg', 'Salad'],
        ),
        FoodItem(
          id: 'f2',
          name: 'Mutton Biryani',
          description: 'Rich and aromatic biryani made with slow-cooked mutton.',
          price: 850,
          image: 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=600',
          category: 'Biryani',
          rating: 4.6,
          addOns: const ['Extra Raita', 'Salad'],
        ),
        FoodItem(
          id: 'f3',
          name: 'Chicken Tikka (2pc)',
          description: 'Charcoal-grilled chicken tikka marinated overnight.',
          price: 380,
          image: 'https://images.unsplash.com/photo-1610057099431-d73a1c9d2f2f?w=600',
          category: 'BBQ',
        ),
      ],
    ),
    Restaurant(
      id: 'r2',
      name: 'Royal Burger Co.',
      cuisine: 'Burgers • Fast Food',
      coverImage:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800',
      logo: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=200',
      rating: 4.5,
      reviewCount: 980,
      distanceKm: 0.8,
      deliveryTimeMins: 20,
      deliveryFee: 79,
      offer: 'Free Delivery',
      menu: [
        FoodItem(
          id: 'f4',
          name: 'Crown Zinger Burger',
          description: 'Crispy zinger patty with signature royal sauce and cheese.',
          price: 690,
          image: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600',
          category: 'Burgers',
          isBestSeller: true,
          addOns: const ['Extra Cheese', 'Extra Patty', 'Jalapenos'],
        ),
        FoodItem(
          id: 'f5',
          name: 'Beef Smash Burger',
          description: 'Double smashed beef patty, caramelized onions, smoked cheddar.',
          price: 750,
          image: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=600',
          category: 'Burgers',
          addOns: const ['Extra Cheese', 'Bacon Bits'],
        ),
        FoodItem(
          id: 'f6',
          name: 'Loaded Fries',
          description: 'Crispy fries loaded with cheese sauce and spices.',
          price: 420,
          image: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=600',
          category: 'Fast Food',
        ),
      ],
    ),
    Restaurant(
      id: 'r3',
      name: 'Palazzo Pizza',
      cuisine: 'Pizza • Italian',
      coverImage:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800',
      logo: 'https://images.unsplash.com/photo-1594007654729-407eedc4be65?w=200',
      rating: 4.4,
      reviewCount: 1320,
      distanceKm: 2.4,
      deliveryTimeMins: 35,
      deliveryFee: 129,
      menu: [
        FoodItem(
          id: 'f7',
          name: 'Fajita Supreme Pizza (Large)',
          description: 'Loaded with chicken fajita, peppers, onions and mozzarella.',
          price: 1450,
          image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600',
          category: 'Pizza',
          isBestSeller: true,
          addOns: const ['Extra Cheese', 'Stuffed Crust'],
        ),
        FoodItem(
          id: 'f8',
          name: 'Cheese Lovers Pizza (Medium)',
          description: 'Four-cheese blend on a crispy hand-tossed base.',
          price: 1100,
          image: 'https://images.unsplash.com/photo-1590947132387-155cc02f3212?w=600',
          category: 'Pizza',
        ),
      ],
    ),
    Restaurant(
      id: 'r4',
      name: 'Dragon Wok Chinese',
      cuisine: 'Chinese • Asian',
      coverImage:
          'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=800',
      logo: 'https://images.unsplash.com/photo-1552611052-33e04de081de?w=200',
      rating: 4.3,
      reviewCount: 640,
      distanceKm: 3.1,
      deliveryTimeMins: 40,
      deliveryFee: 149,
      menu: [
        FoodItem(
          id: 'f9',
          name: 'Chicken Chowmein',
          description: 'Stir-fried noodles with chicken and crunchy vegetables.',
          price: 480,
          image: 'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=600',
          category: 'Chinese',
        ),
        FoodItem(
          id: 'f10',
          name: 'Sweet & Sour Chicken',
          description: 'Crispy chicken tossed in tangy sweet and sour sauce.',
          price: 560,
          image: 'https://images.unsplash.com/photo-1525755662778-989d0524087e?w=600',
          category: 'Chinese',
        ),
      ],
    ),
  ];

  static List<FoodItem> get allFoodItems =>
      restaurants.expand((r) => r.menu).toList();

  static final List<FoodOrder> pastOrders = [
    FoodOrder(
      id: 'KF-10234',
      restaurantName: "King's Biryani House",
      restaurantLogo: restaurants[0].logo,
      itemSummaries: ['Chicken Biryani (Full) x1', 'Boiled Egg x1'],
      total: 750,
      placedAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      status: OrderStatus.delivered,
    ),
    FoodOrder(
      id: 'KF-10198',
      restaurantName: 'Royal Burger Co.',
      restaurantLogo: restaurants[1].logo,
      itemSummaries: ['Crown Zinger Burger x2', 'Loaded Fries x1'],
      total: 1800,
      placedAt: DateTime.now().subtract(const Duration(days: 4)),
      status: OrderStatus.delivered,
    ),
  ];
}
