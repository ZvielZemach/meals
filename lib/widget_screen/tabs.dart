import 'package:flutter/material.dart';
import 'package:meals/widget_non_screen/main_drawer.dart';
import 'package:meals/widget_screen/categories.dart';
import 'package:meals/widget_screen/filters.dart';
import 'package:meals/widget_screen/meals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/favorites_provider.dart';
import 'package:meals/provider/filters_provider.dart';


const kInitialFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegen: false,
    Filter.vegetarian: false,
  };

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ConsumerTabsState();
  }
}

class _ConsumerTabsState extends ConsumerState<Tabs> {
  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      await Navigator.of(context).push<Map<Filter , bool>>(
        MaterialPageRoute(
          builder: (ctx) => const Filters(),
        ),
      );
    }
    // } else {
    //   Navigator.of(context).pop();
    // }
  }

  @override
  Widget build(BuildContext context) {
   
   final avilavleMeals = ref.watch(filterMealsProvider);

    Widget activePage = Categories(
      availableMeals: avilavleMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoritesMeals = ref.watch(favoritesMealsProviders);
      activePage = MealsScreen(
        meals: favoritesMeals,
      );
      activePageTitle = 'Your favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _selectScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
