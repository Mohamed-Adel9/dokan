import 'package:dokan/features/payment/presentation/bloc/payment_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paymob/flutter_paymob.dart';


class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  // final PaymentRepository _repo;

  Future<void> payWithCard({
    required BuildContext context,
    required double amount,
  }) async {
    emit(PaymentLoading());
    try {
      await FlutterPaymob.instance.payWithCard(
        context: context,
        currency: 'EGP',
        amount: amount,
        onPayment: (response) {
          if (response.success) {
            // Save transaction to Firestore

            emit(PaymentSuccess(
              transactionId: response.transactionID ?? '',
              message: 'Payment successful',
            ));
          } else {
            emit(PaymentFailure(response.message ?? 'Payment failed'));
          }
        },
      );
    } catch (e) {
      emit(PaymentFailure('An error occurred: $e'));
    }
  }

  Future<void> payWithWallet({
    required BuildContext context,
    required double amount,
    required String phoneNumber,
  }) async {
    emit(PaymentLoading());
    try {
      await FlutterPaymob.instance.payWithWallet(
        context: context,
        currency: 'EGP',
        amount: amount,
        number: phoneNumber,
        onPayment: (response) {
          if (response.success) {

            emit(PaymentSuccess(
              transactionId: response.transactionID ?? '',
              message: 'Wallet payment successful',
            ));
          } else {
            emit(PaymentFailure(response.message ?? 'Wallet payment failed'));
          }
        },
      );
    } catch (e) {
      emit(PaymentFailure('An error occurred: $e'));
    }
  }
}