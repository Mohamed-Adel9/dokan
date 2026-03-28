import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/core/navigation/route_names.dart';
import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/features/home/domain/entities/product.dart';
import 'package:flutter/material.dart';

import '../../features/home/presentation/shopping/product_screen_args.dart';


class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  Future<void> updateProductFavorite() async {
    await FirebaseFirestore.instance
        .collection('product')
        .doc(product.id)
        .update({'isFavorite': !product.isFavorite});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.product,
          arguments:ProductScreenArgs(
              categoryName: product.categoryName,
              products: product,
              categoryKind: product.category,
        ), );
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE + BADGES
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],

              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      product.image,
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// discount badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${product.discount}\$",
                        style: AppTextStyles.helperText.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  /// favorite icon
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: const BoxDecoration(

                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          updateProductFavorite();
                        },
                        icon: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// rating
            Row(
              children: [
                ...List.generate(
                  product.rate,
                  (index) =>
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                ),
              ],
            ),

            const SizedBox(height: 4),

            /// brand
            Text(
              product.categoryName,
              style: AppTextStyles.helperText.copyWith(
                color: Colors.white.withAlpha(1000),
              ),
            ),

            const SizedBox(height: 2),

            /// product name
            Text(product.productName, style: AppTextStyles.subheads),

            const SizedBox(height: 6),

            /// price
            Row(
              children: [
                Text(
                  "${product.price}\$",
                  style: AppTextStyles.helperText.copyWith(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  "${product.price - ((product.price / 100) * product.discount)}\$",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
