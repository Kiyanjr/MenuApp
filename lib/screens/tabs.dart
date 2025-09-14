import 'package:flutter/material.dart';
import 'package:food/data/dummy_data.dart';
import 'package:food/models/meal.dart';
import 'package:food/screens/categories.dart';
import 'package:food/screens/filters.dart';
import 'package:food/screens/meals.dart';
import 'package:food/widgets/mainDraw.dart';

//global variable
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactosFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageNumber = 0;

  final List<Meal> _favoriteMeal = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _addRemoveFavoriteMealStatus(Meal meal) {
    final isExisting = _favoriteMeal.contains(meal);

    if (isExisting == true) {
      setState(() {
        _favoriteMeal.remove(meal);
      });
      _showInfoMessage('Removed from favorite list.');
    } else {
      setState(() {
        _favoriteMeal.add(meal);
        _showInfoMessage('Added as a Favrite !.');
      });
    }
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageNumber = index;
    });
  }

  void _setScreen(String identifire) async {
    Navigator.of(context).pop(); //<--close the draw and the n navigate
    if (identifire == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilter: _selectedFilters),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }

      if (_selectedFilters[Filter.lactosFree]! && !meal.isLactoseFree) {
        return false;
      }

      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }

      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true; //return the food
    }).toList();
    Widget activePage = CategoriesScreen(
      addRemoveFavoriteMeal: _addRemoveFavoriteMealStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageNumber == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeal,
        addRemoveFavoriteMeal: _addRemoveFavoriteMealStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      drawer: Maindraw(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal_rounded),
            label: 'Categories.',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        onTap: _selectedPage,
        currentIndex: _selectedPageNumber, //<-highlighting the selected tab
      ),
    );
  }
}
