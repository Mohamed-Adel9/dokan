import 'package:dokan/shared/widgets/color_drop_down.dart';
import 'package:dokan/shared/widgets/size_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/home/domain/entities/product.dart';
import '../../../features/home/presentation/home/bloc/home_cubit.dart';

class TopActions extends StatelessWidget {
  final Product product;

  const TopActions({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizeDropdown(),
        const SizedBox(width: 10),
        const ColorDropdown(),
        const Spacer(),

        /// Favorite
        Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              context.read<HomeCubit>().toggleFavorite(product);
            },
            icon: Icon(
              product.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}