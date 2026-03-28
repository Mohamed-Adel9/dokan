import 'package:dokan/core/localization/app_localization.dart';
import 'package:dokan/features/home/domain/entities/rate.dart';
import 'package:flutter/material.dart';

import 'review_card.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key, required this.ratings});
  final List<Rate> ratings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Header
        Text(
          "${ratings.length} ${AppLocalizations.of(context).translate('reviews')}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        /// Reviews list
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ratings.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ReviewCard(rateModel: ratings[index]),
          ),
        ),

        /// Write review button
      ],
    );
  }
}


