import 'package:dokan/core/navigation/route_names.dart';
import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/features/checkout/presentation/bloc/checkout_cubit.dart';
import 'package:dokan/features/checkout/presentation/bloc/checkout_state.dart';
import 'package:dokan/features/home/presentation/bag/bloc/cart_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localization.dart';
import '../../../shared/functions/payment_widget.dart';
import '../../../shared/functions/price_summary.dart';
import '../../../shared/widgets/auth_button.dart';
import '../../home/presentation/bag/bloc/cart_cubit.dart';
import '../domain/entity/address_model.dart';

class CheckOutScreen extends StatelessWidget {
  final double totalPrice;
  final double totalPriceAfterDiscount;
  final double delivery;
  const CheckOutScreen({
    super.key,
    required this.totalPrice,
    required this.totalPriceAfterDiscount,
    required this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    final locale = AppLocalizations.of(context);
    final uid=  FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: Text(locale.translate("checkout"))),

      body: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          final address = state.address;
          final paymentMethod = state.paymentMethod;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// SHIPPING ADDRESS
                _ShippingAddressSection(
                  address: address,
                  onChange: () => cubit.selectAddress(context),
                ),

                const SizedBox(height: 30),

                /// PAYMENT METHOD
                _PaymentSection(
                  paymentMethod: paymentMethod,
                  onChange: () => cubit.selectPaymentMethod(
                    context,
                    totalPrice: totalPrice,
                    totalPriceAfterDis: totalPriceAfterDiscount,
                  ),
                ),

                const Spacer(),

                /// PRICE SUMMARY
                PriceSummary(
                  delivery: delivery,
                  subtotal: totalPrice,
                  totalAfterDiscount: totalPriceAfterDiscount,
                ),

                const SizedBox(height: 12),

                /// SUBMIT BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: AuthButton(
                    text: locale.translate("submit_order"),
                      onPressed: () {
                        final checkoutState = context.read<CheckoutCubit>().state;
                        final cartState = context.read<CartCubit>().state;
                        final cartCubit = context.read<CartCubit>();

                        // ✅ Validate address
                        if (checkoutState.address == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(locale.translate("choose_address"))),
                          );
                          return;
                        }

                        // ✅ Validate payment method
                        if (checkoutState.paymentMethod == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(locale.translate("choose_payment_method"))),
                          );
                          return;
                        }

                        // ✅ Validate cart
                        if (cartState is CartLoadedState) {
                          final cartItems = cartState.items;

                          context.read<CheckoutCubit>().submitOrder(
                            cartItems,
                            totalPriceAfterDiscount,
                          );

                          cartCubit.clearCart(uid);

                          Navigator.pushNamed(
                            context,
                            RouteNames.checkoutSuccess,
                          );
                        }
                      }
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ShippingAddressSection extends StatelessWidget {
  final AddressModel? address;
  final VoidCallback onChange;

  const _ShippingAddressSection({
    required this.address,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              locale.translate("shipping_address"),
              style: AppTextStyles.subheads,
            ),
            TextButton(
              onPressed: onChange,
              child: Text(locale.translate("change")),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),

          child: address == null
              ? Text(locale.translate("choose_address"))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(address!.name, style: AppTextStyles.descriptiveItems),
                    const SizedBox(height: 4),
                    Text(
                      address!.address,
                      style: AppTextStyles.descriptionText,
                    ),
                    Text(
                      "${address!.city}, ${address!.country}",
                      style: AppTextStyles.descriptionText,
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

class _PaymentSection extends StatelessWidget {
  final String? paymentMethod;
  final VoidCallback onChange;

  const _PaymentSection({required this.paymentMethod, required this.onChange});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              locale.translate("payment_method"),
              style: AppTextStyles.subheads,
            ),
            TextButton(
              onPressed: onChange,
              child: Text(locale.translate("change")),
            ),
          ],
        ),

        const SizedBox(height: 10),

        if (paymentMethod == null)
          Text(locale.translate("choose_payment_method"))
        else
          paymentWidget(context, paymentMethod!),
      ],
    );
  }
}
