import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localization.dart';
import '../../../features/home/domain/entities/bag/cart_item.dart';
import '../../../features/home/domain/entities/product.dart';
import '../../../features/home/presentation/bag/bloc/cart_cubit.dart';
import '../auth_button.dart';

class AddToCartButton extends StatelessWidget {
  final Product product;

  const AddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context) ;

    return AuthButton(
      text: locale.translate('add_to_cart'),
      onPressed: () {
        final item = CartItem(
          name: product.productName,
          image: product.image,
          productId: product.id,
          price: product.price,
          quantity: 1,
          discount: product.discount.toDouble(),
        );
        context.read<CartCubit>().addToCart(item);
      },
    );
  }
}