import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import '../../../../core/errors/failures.dart';
import '../entitiy/transaction_entity.dart';
import '../failure/payment_initailzation_failure.dart';
import '../repository/payment_repository.dart';

class PayWithWalletUseCase {
  final PaymentRepository _repository;
  const PayWithWalletUseCase(this._repository);

  Future<Either<Failures, TransactionEntity>> call({
    required BuildContext context,
    required double amount,
    required String currency,
    required String phoneNumber,
  }) async {
    try {
      Either<Failures, TransactionEntity>? result;

      await FlutterPaymob.instance.payWithWallet(
        context: context,
        currency: currency,
        amount: amount,
        number: phoneNumber,
        onPayment: (response) async {
          if (response.success) {
            result = await _repository.saveTransaction(
              amount: amount,
              currency: currency,
              method: PaymentMethod.wallet,
              status: PaymentStatus.success,
              paymobTransactionId: response.transactionID,
            );
          } else {
            await _repository.saveTransaction(
              amount: amount,
              currency: currency,
              method: PaymentMethod.wallet,
              status: PaymentStatus.failed,
              failureReason: response.message,
            );
            result = Left(
              PaymentDeclinedFailure(
                  response.message ?? 'Wallet payment declined'),
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