import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/shared/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localization.dart';
import '../../../../shared/widgets/home_banner_widget.dart';
import 'bloc/home_cubit.dart';
import 'bloc/home_states.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 1, child: HomeBannerWidget()),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height / 2,
              child: SingleChildScrollView(
                child: BlocBuilder<HomeCubit, HomeStates>(
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return Center(child: const CircularProgressIndicator());
                    }
                    if (state is HomeLoadedState) {
                      return Column(
                        children: [
                          // product head data
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppLocalizations.of(context).translate('sale'), style: AppTextStyles.headline),
                                  Text(
                                    AppLocalizations.of(context).translate('super_sale'),
                                    style: AppTextStyles.helperText.copyWith(
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  // todo view all products
                                },
                                child: Text(
                                  AppLocalizations.of(context).translate('view_all'),
                                  style: AppTextStyles.helperText,
                                ),
                              ),
                            ],
                          ),

                          //products
                          SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: state.product.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final product = state.product[index];
                                return ProductCard(product: product,);
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return Text(
                      "OOPS! Something went wrong",
                      style: AppTextStyles.headline,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
