import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/features/home/presentation/product/bloc/rate_cubit.dart';
import 'package:dokan/features/home/presentation/product/bloc/rate_states.dart';
import 'package:dokan/features/home/presentation/product/rating_bottom_sheet.dart';
import 'package:dokan/shared/widgets/auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
              return const Center(child: CircularProgressIndicator());
            }

            if (state is RatingLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ReviewsScreen(ratings: state.rate),
                    const SizedBox(height: 30),
                    AuthButton(
                      text: AppLocalizations.of(context).translate('write_comment'),
                      onPressed: () => _showRatingSheet(context),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: Text("OOPS! Something went wrong!"));
          },
        ),
      ),
    );
  }

  void _showRatingSheet(BuildContext context) {
    final cubit = context.read<RatingCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child:  RatingBottomSheet(),
      ),
    );
  }
}


class UserUtils {
  static String resolveUserName(User? user) {
    return user?.displayName ?? user?.email?.split('@').first ?? 'User';
  }
}