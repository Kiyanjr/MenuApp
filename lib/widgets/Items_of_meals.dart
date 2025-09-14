import 'package:flutter/material.dart';
import 'package:food/models/meal.dart';
import 'package:food/widgets/meal_item_widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsItem extends StatelessWidget {
  const MealsItem({super.key, required this.onselectMeal, required this.meal});

  final Meal meal;
  final void Function(Meal meal) onselectMeal;
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      child: InkWell(
        onTap: () {
          onselectMeal(meal);
        },

        child: Stack(
          //<---C part in stack widget
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0, //<-- going top of image
              right: 0,
              child: Container(
                color: const Color.fromARGB(113, 0, 0, 0),
                padding: const EdgeInsetsGeometry.symmetric(
                  vertical: 6,
                  horizontal: 40,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // shows ........
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),

                    Row(
                      //meta data
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemWidget(
                          icon: Icons.schedule_sharp,
                          lable: '${meal.duration} min',
                        ),

                        const SizedBox(width: 14),

                        MealItemWidget(icon: Icons.work, lable: complexityText),

                        const SizedBox(width: 14),

                        MealItemWidget(
                          icon: Icons.attach_money_rounded,
                          lable: affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
