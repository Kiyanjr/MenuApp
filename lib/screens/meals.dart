import 'package:flutter/material.dart';
import 'package:food/models/meal.dart';
import 'package:food/screens/meals_details_screen.dart';
import 'package:food/widgets/Items_of_meals.dart';
import 'package:google_fonts/google_fonts.dart';

class MealsScreen extends StatelessWidget{
  const MealsScreen({super.key, this.title,required this.meals,required this.addRemoveFavoriteMeal});

final String? title;
final List<Meal> meals;
final void Function(Meal meal) addRemoveFavoriteMeal;
void selectMeal(BuildContext context,Meal meal){
  Navigator.of(context).push(MaterialPageRoute(builder:(context)=>MealsDetailsScreen(
    meal:meal,
  addRemoveFavoriteMeal:addRemoveFavoriteMeal ,),
  ),
  );
}
  @override
  Widget build(BuildContext context) {
   if(title==null){
    return meals.isEmpty
    ?_buildEmptyList(context) : _buildMealView();
   }
   
   return Scaffold(
  appBar:  AppBar(
    title: Text(title!),
  ),
  body: meals.isEmpty? _buildEmptyList(context):_buildMealView(),
   );
  }
  //------------EMPYT LIST----------
  Widget _buildEmptyList(BuildContext context){
    return Center(
  child: Column(
    mainAxisSize:MainAxisSize.min,
    children: [
      Text(
    '......No selected Category here....',
    textAlign: TextAlign.center,
     style: GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
      color: Theme.of(context).colorScheme.onSecondary,
    ),
  ),
      ),
      const SizedBox(height: 16),
      Text(
       'Try selecting a diffrent category!!',
       textAlign: TextAlign.end,
       style: GoogleFonts.inter(textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color:Theme.of(context).colorScheme.onSurface,
       ),
       ),
      ),
    ],
  ),
    );
  }
      //-----view list-----
Widget _buildMealView(){
return ListView.builder(
itemCount:meals.length, 
itemBuilder:(context,index){
 return MealsItem(meal:meals[index],onselectMeal:(meal){
 selectMeal(context, meal);
 } ,
 );
 }
);
}


}