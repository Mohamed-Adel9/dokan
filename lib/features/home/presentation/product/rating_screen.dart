import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/features/home/presentation/product/bloc/rate_cubit.dart';
import 'package:dokan/features/home/presentation/product/bloc/rate_states.dart';
import 'package:dokan/shared/widgets/auth_button.dart';
import 'package:dokan/shared/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../shared/widgets/reviews_section.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('rating_and_reviews'),
          style: AppTextStyles.headline2,
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<RatingCubit, RatingStates>(
          builder: (context, state) {
            if (state is RatingLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is RatingLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ReviewsScreen(ratings: state.rate),
                    SizedBox(height: 30),
                    AuthButton(
                      text: AppLocalizations.of(
                        context,
                      ).translate('write_comment'),
                      onPressed: () {
                        final cubit = context.read<RatingCubit>();
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return BlocProvider.value(
                              value: cubit,
                              child: RatingBottomSheet(),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return Center(child: Text("OOPS! Something went wrong!"));
          },
        ),
      ),
    );
  }
}

class RatingBottomSheet extends StatelessWidget {
  final TextEditingController rateController = TextEditingController();

  RatingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingCubit, RatingStates>(
      builder: (context, state) {
        final cubit = context.read<RatingCubit>();
        return Container(
          padding: const EdgeInsets.all(20),
          height: 800,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context).translate('what_is_your_rate'),
                style: AppTextStyles.headline3,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => IconButton(
                    onPressed: () {
                      cubit.setRate(index);
                    },
                    icon: Icon(
                      index < cubit.rating ? Icons.star : Icons.star_border,
                      size: 40,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              SizedBox(
                height: 80,
                width: MediaQuery.sizeOf(context).width * .6,
                child: Text(
                  AppLocalizations.of(context).translate('opinion'),
                  style: AppTextStyles.headline3,
                  textAlign: TextAlign.center,
                ),
              ),
              AuthTextField(
                hint: AppLocalizations.of(context).translate('write_comment'),
                controller: rateController,
              ),
              SizedBox(height: 50),
              AuthButton(
                text: AppLocalizations.of(context).translate('send_review'),
                onPressed: () {
                  //todo add user name
                  cubit.addReview(
                    cubit.rating,
                    "mohameddd",
                    rateController.text,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
