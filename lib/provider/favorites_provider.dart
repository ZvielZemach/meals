import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class favoritesMealsNotifier extends StateNotifier<List<Meal>> {
  favoritesMealsNotifier() : super([]);

  bool toggleMealFavoritesStatus(Meal meal) {
    final mealIsFavorites = state.contains(meal);

    if (mealIsFavorites) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoritesMealsProviders =
    StateNotifierProvider<favoritesMealsNotifier, List<Meal>>((ref) {
  return favoritesMealsNotifier();
});
