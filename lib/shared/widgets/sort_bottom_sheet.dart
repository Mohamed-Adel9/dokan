import 'package:dokan/core/localization/app_localization.dart';
import 'package:dokan/features/home/presentation/home/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/domain/enums/product_sort_type.dart';

class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

           Text(
            locale.translate('sort_by'),
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),
          _item(context, locale.translate('newest'), ProductSortType.newest),
          _item(context, locale.translate('customer_review'), ProductSortType.rating),
          _item(context, locale.translate('price_low'), ProductSortType.priceLowToHigh),
          _item(context, locale.translate('price_high'), ProductSortType.priceHighToLow),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, String title, ProductSortType type) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {

        context.read<HomeCubit>().sortProducts(type);
        Navigator.pop(context);
      },
    );
  }
}