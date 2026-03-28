import 'package:flutter/material.dart';

import '../../features/home/domain/entities/rate.dart';

class ReviewCard extends StatelessWidget {
  final Rate rateModel ;
  const ReviewCard({super.key, required this.rateModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color :Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// User info
          Row(
            children: [
               CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  rateModel.image,
                ),
              ),
              const SizedBox(width: 10),
               Expanded(
                child: Text(
                  rateModel.userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
               Text(
                rateModel.time.toString(),
                style: TextStyle( fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// Stars
          Row(
            children: List.generate(
              rateModel.rate,
                  (index) => const Icon(Icons.star, color: Colors.amber, size: 18),
            ),
          ),

          const SizedBox(height: 10),

          /// Review text
           Text(
            rateModel.review,
            style: TextStyle( height: 1.4),
          ),

          const SizedBox(height: 12),


        ],
      ),
    );
  }
}