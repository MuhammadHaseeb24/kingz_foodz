import 'package:flutter/foundation.dart';
import '../models/restaurant.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favoriteIds = {};

  bool isFavorite(Restaurant r) => _favoriteIds.contains(r.id);

  void toggle(Restaurant r) {
    if (_favoriteIds.contains(r.id)) {
      _favoriteIds.remove(r.id);
    } else {
      _favoriteIds.add(r.id);
    }
    notifyListeners();
  }

  List<Restaurant> favoritesFrom(List<Restaurant> all) =>
      all.where((r) => _favoriteIds.contains(r.id)).toList();
}
