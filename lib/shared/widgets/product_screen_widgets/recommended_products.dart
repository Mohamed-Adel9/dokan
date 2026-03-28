import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localization.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../features/home/presentation/home/bloc/home_cubit.dart';
import '../../../features/home/presentation/home/bloc/home_states.dart';
import '../product_card.dart';

class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context) ;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(locale.translate("you_can_also_like"), style: AppTextStyles.headline3),
        const SizedBox(height: 10),

        SizedBox(
          height: 300,
          child: BlocBuilder<HomeCubit, HomeStates>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is HomeLoadedState) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.product.length,
                  itemBuilder: (_, index) {
                    return ProductCard(product: state.product[index]);
                  },
                );
              }

              return const Center(child: Text("Something went wrong"));
            },
          ),
        ),
      ],
    );
  }
}
