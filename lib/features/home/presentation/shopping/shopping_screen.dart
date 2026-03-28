import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/features/home/presentation/shopping/bloc/shopping_cubit.dart';
import 'package:dokan/features/home/presentation/shopping/bloc/shopping_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../shared/widgets/category_view_builder.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCubit, ShoppingStates>(
      builder: (context, state) {
        if (state is ShoppingLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ShoppingLoadedState) {
          final womenCategories = state.categories
              .where((c) => c.category == 'women')
              .toList();

          final menCategories = state.categories
              .where((c) => c.category == 'men')
              .toList();

          final kidsCategories = state.categories
              .where((c) => c.category == 'kids')
              .toList();
          return DefaultTabController(
            length: 3,
            animationDuration: Duration(milliseconds: 400),
            initialIndex: 0,
            child: Column(
              children: [
                TabBar(

                  indicatorWeight: 4,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(child: Text(AppLocalizations.of(context).translate('women'), style: AppTextStyles.subheads)),
                    Tab(child: Text(AppLocalizations.of(context).translate('men'), style: AppTextStyles.subheads)),
                    Tab(child: Text(AppLocalizations.of(context).translate('kids'), style: AppTextStyles.subheads)),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TabBarView(
                      children: [
                        CategoryViewBuilder(
                          categories: womenCategories,
                          count: womenCategories.length,
                        ),
                        CategoryViewBuilder(
                          categories: menCategories,
                          count: menCategories.length,
                        ),
                        CategoryViewBuilder(
                          categories: kidsCategories,
                          count: kidsCategories.length,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Text(
          "OOPS! Something went wrong",
          style: AppTextStyles.headline,
        );
      },
    );
  }
}
