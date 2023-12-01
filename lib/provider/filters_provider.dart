import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegen }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegen: false,
        });

  void SetFilters(Map<Filter , bool> chosenFilters) {
    state = chosenFilters;
  }

  void SetFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());


final filterMealsProvider = Provider((ref) {
  
    final meal = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);

      return meal.where((meal) {
      if(activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if(activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if(activeFilters[Filter.vegen]! && !meal.isVegan) {
        return false;
      }
      if(activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
});