import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/features/home/presentation/home/bloc/home_states.dart';
import 'package:dokan/shared/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/home/bloc/home_cubit.dart';

class FavoriteViewBuilder extends StatelessWidget {

  const FavoriteViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: BlocBuilder<HomeCubit, HomeStates>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is HomeLoadedState) {
              final favoriteProducts = state.product
                  .where((p) => p.isFavorite)
                  .toList();

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .62,
                ),
                physics: BouncingScrollPhysics(),
                itemCount: favoriteProducts.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return ProductCard(product: favoriteProducts[index]);
                },
              );
            }
            return Center(
              child: Text(
                "OOPS! Something went wrong!",
                style: AppTextStyles.headline,
              ),
            );
          },
        ),
      ),
    );
  }
}
