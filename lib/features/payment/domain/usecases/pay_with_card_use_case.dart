import 'package:dartz/dartz.dart';
import 'package:dokan/core/errors/failures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';

import '../entitiy/transaction_entity.dart';
import '../failure/payment_initailzation_failure.dart';
import '../repository/payment_repository.dart';

class PayWithCardUseCase {
  final PaymentRepository _repository;
  const PayWithCardUseCase(this._repository);

  Future<Either<Failures, TransactionEntity>> call({
    required BuildContext context,
    required double amount,
    required String currency,
  }) async {
    try {
      Either<Failures, TransactionEntity>? result;

      await FlutterPaymob.instance.payWithCard(
        context: context,
        currency: currency,
        amount: amount,
        onPayment: (response) async {
          if (response.success) {
            result = await _repository.saveTransaction(
              amount: amount,
              currency: currency,
              method: PaymentMethod.card,
              status: PaymentStatus.success,
              paymobTransactionId: response.transactionID,
            );
          } else {
            // Save failed attempt for auditing
            await _repository.saveTransaction(
              amount: amount,
              currency: currency,
              method: PaymentMethod.card,
              status: PaymentStatus.failed,
              failureReason: response.message,
            );
            result = Left(
              PaymentDeclinedFailure(
                  response.message ?? 'Card payment declined'),
            );
          }
        },
      );

      return result ?? Left(const PaymentCancelledFailure());
    } catch (e) {
      return Left(PaymentInitializationFailure(e.toString()));
    }
  }
}