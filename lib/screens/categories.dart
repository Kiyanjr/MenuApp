import 'package:flutter/material.dart';
import 'package:food/data/dummy_data.dart';
import 'package:food/models/category.dart';
import 'package:food/models/meal.dart';
import 'package:food/screens/meals.dart';
import 'package:food/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget{
  const CategoriesScreen({super.key,required this.addRemoveFavoriteMeal,required this.availableMeals});

final void Function(Meal meal) addRemoveFavoriteMeal;
final List<Meal>availableMeals;
//---loading Diffrent screen
void _selectedCategory(BuildContext context,Category category){
  final mealsList =availableMeals
  .where((meal)=>meal.categories.contains(category.id)).toList();

 
    Navigator.push(
     context, 
    MaterialPageRoute(builder:(context)=>MealsScreen(
    title:category.title, 
    meals:mealsList,
    addRemoveFavoriteMeal: addRemoveFavoriteMeal,
    ),
   ),
   );

}


  @override
  Widget build(BuildContext context) {
    return GridView( 
        padding: EdgeInsets.all(24),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        ),//<----  tedad  satr , size tol arz chand bashad
      children:[
          for(final category in availableCategories)
          CategoryGirdItem(category: category,onselectCategory: (){
            _selectedCategory(context,category);
          }   
          ),
      ],
      );
  }
}