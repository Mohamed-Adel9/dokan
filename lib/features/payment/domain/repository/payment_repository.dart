import 'package:dartz/dartz.dart';
import 'package:dokan/core/errors/failures.dart';

import '../entitiy/transaction_entity.dart';

abstract class PaymentRepository {
  Future<Either<Failures, TransactionEntity>> saveTransaction({
    required double amount,
    required String currency,
    required PaymentMethod method,
    required PaymentStatus status,
    String? paymobTransactionId,
    String? failureReason,
  }) ;

  /// Fetch all transactions for the current user
  Future<Either<Failures, List<TransactionEntity>>> getUserTransactions();

  /// Fetch one transaction by Firestore document ID
  Future<Either<Failures, TransactionEntity>> getTransactionById(
      String id);
}