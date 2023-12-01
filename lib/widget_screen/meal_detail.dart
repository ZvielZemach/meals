import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/provider/favorites_provider.dart';


class MealDetail extends ConsumerWidget {
  const MealDetail({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoritesMealsProviders);

    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoritesMealsProviders.notifier)
                  .toggleMealFavoritesStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                content: Text(
                  wasAdded
                      ? 'meal added as favorites'
                      : 'meal deleted from favorites',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.error, 
                      ),
                ),
              ));
            },
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
          ),
        ],
      ),
      body: Column(
        children: [
          Image(
            image: NetworkImage(meal.imageUrl),
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'The ingredients are:',
            style: TextStyle(
              color: Color.fromARGB(179, 245, 2, 2),
              fontSize: 20,
            ),
          ),
          for (final ingredient in meal.ingredients)
            Text(
              ingredient,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'The steps are:',
            style: TextStyle(
              color: Color.fromARGB(179, 245, 2, 2),
              fontSize: 20,
            ),
          ),
          for (final step in meal.steps)
            Text(
              step,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
