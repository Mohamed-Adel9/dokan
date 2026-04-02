import 'package:flutter/material.dart';

import '../../../core/localization/app_localization.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../features/home/domain/entities/product.dart';

class ProductInfo extends StatelessWidget {
  final Product product;

  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context) ;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Discount badge
        if (product.hasDiscount)
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "${product.discount.toInt()}% ${locale.translate('off')}",
              style: AppTextStyles.descriptionText
                  .copyWith(color: AppColors.error),
            ),
          ),

        Row(
          children: [
            Expanded(
              child: Text(
                product.productName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            if (product.hasDiscount)
              Text(
                "\$${product.price}",
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                ),
              ),

            const SizedBox(width: 5),

            Text(
              "\$${product.finalPrice}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        Text(
          product.categoryName,

        ),

        const SizedBox(height: 10),

        /// Rating
        Row(
          children: List.generate(
            product.rate,
                (_) => const Icon(Icons.star, size: 14, color: Colors.amber),
          ),
        ),

        const SizedBox(height: 14),

         Text(
          product.info,

        ),
      ],
    );
  }
}