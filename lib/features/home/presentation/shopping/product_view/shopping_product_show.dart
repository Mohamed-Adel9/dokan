import 'package:dokan/features/home/domain/entities/product.dart';
import 'package:dokan/shared/widgets/product_card.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/functions/show_sortby_bottom_sheet.dart';

class ShoppingProductShow extends StatelessWidget {
  final String categoryName;
  final String categoryKind;
  final List<Product> products;

  const ShoppingProductShow({
    super.key,
    required this.categoryName,
    required this.products,
    required this.categoryKind,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actionsPadding: EdgeInsets.symmetric(horizontal: 16),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          "$categoryKind $categoryName's",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),

          /// ================= FILTER ROW =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(
                  Icons.filter_list,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(width: 6),
                Text(
                  "Filters",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const Spacer(),

                IconButton(
                  onPressed: () {
                    showSortBottomSheet(context);
                  },
                  icon: Icon(
                    Icons.swap_vert,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                Text(
                  "Sort By",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const Spacer(),

                Icon(
                  Icons.grid_view,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// ================= PRODUCTS GRID =================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                itemCount: products.length, // from cubit later
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
