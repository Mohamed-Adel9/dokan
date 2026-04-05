import 'package:dokan/features/checkout/domain/entity/address_model.dart';
import 'package:dokan/features/checkout/domain/usecases/create_order_use_case.dart';
import 'package:dokan/features/checkout/presentation/bloc/checkout_state.dart';
import 'package:dokan/features/home/domain/entities/bag/cart_item.dart';
import 'package:dokan/features/checkout/domain/entity/order_entity.dart';
import 'package:dokan/features/checkout/presentation/payment_method_screen.dart';
import 'package:dokan/core/navigation/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CreateOrderUseCase createOrderUseCase;
  final FirebaseAuth auth = FirebaseAuth.instance;

  CheckoutCubit(this.createOrderUseCase) : super(CheckoutState());

  // ── Pass totalPrice so PaymentMethodScreen knows the amount ──
  Future<void> selectPaymentMethod(
      BuildContext context, {
        required double totalPrice,
        required double totalPriceAfterDis,
      }) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentMethodScreen(orderAmount: totalPrice, orderAmountAfterDis: totalPriceAfterDis,),
      ),
    );


    if (result != null) {
      emit(state.copyWith(paymentMethod: result));
    }
  }

  Future<void> selectAddress(BuildContext context) async {
    final result = await Navigator.pushNamed(
      context,
      RouteNames.address,
    ) as AddressModel?;

    if (result != null) {
      emit(state.copyWith(address: result));
    }
  }

  Future<void> submitOrder(
      List<CartItem> cartItems,
      double totalPrice,
      ) async {
    if (state.address == null) {
      emit(state.copyWith(errorMessage: 'Please select an address'));
      return;
    }

    if (state.paymentMethod == null) {
      emit(state.copyWith(errorMessage: 'Please select a payment method'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final orderItems = cartItems.map((item) => CartItem(
        productId: item.productId,
        name: item.name,
        image: item.image,
        price: item.price,
        quantity: item.quantity,
        discount: item.discount,
      )).toList();

      final order = OrderEntity(
        userId: auth.currentUser!.uid,
        paymentMethod: state.paymentMethod!,
        totalPrice: totalPrice,
        deliveryPrice: 25,
        address: state.address!.address,
        city: state.address!.city,
        country: state.address!.country,
        status: _orderStatus(state.paymentMethod!),
        createdAt: DateTime.now(),
        item: orderItems,
      );

      await createOrderUseCase(order);
      emit(state.copyWith(isLoading: false, orderSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Something went wrong. Please try again.',
      ));
    }
  }

  // Cash → pending, card/wallet → paid (Paymob already charged them)
  String _orderStatus(String paymentMethod) {
    switch (paymentMethod) {
      case 'card':
      case 'vodafone':
        return 'paid';
      default:
        return 'pending';
    }
  }
}