//this part goes to gridview widget int screen/categories.dart
import 'package:flutter/material.dart';
import 'package:food/models/category.dart';

class CategoryGirdItem extends StatelessWidget {
  const CategoryGirdItem({
    super.key,
    required this.category,
    required this.onselectCategory,
  });

  final Category category;

  final void Function() onselectCategory; //<--loaing a diff page

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //<--getting feedback and userTapable
      onTap: onselectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),

      child: Container(
        //<--using container cuz of backgrounad color stuff
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withValues(alpha: 0.55),
              category.color.withValues(alpha: 0.9),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
