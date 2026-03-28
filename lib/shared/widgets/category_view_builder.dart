import 'package:dokan/core/navigation/route_names.dart';
import 'package:dokan/features/home/domain/entities/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/home/presentation/home/bloc/home_cubit.dart';
import '../../features/home/presentation/shopping/shopping_args.dart';
import 'category_card.dart';

class CategoryViewBuilder extends StatelessWidget {
  final List<Categories> categories;

  final int count;

  const CategoryViewBuilder({
    super.key,
    required this.categories,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: count,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              final selectedCategory = categories[index];

              final homeCubit = context.read<HomeCubit>();

              final products = homeCubit.getProductsByCategory(
                selectedCategory.category,
              );

              Navigator.pushNamed(
                context,
                RouteNames.shoppingProductShow,
                arguments: ShoppingArgs(
                  categoryName: selectedCategory.item,
                  products: products,
                  categoryKind: selectedCategory.category,
                ),
              );
            },
            child: CategoryCard(
              title: categories[index].item,
              image: categories[index].image,
            ),
          );
        },
      ),
    );
  }
}
