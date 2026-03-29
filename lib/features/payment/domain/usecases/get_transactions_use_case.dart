import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entitiy/transaction_entity.dart';
import '../repository/payment_repository.dart';

class GetTransactionsUseCase {
  final PaymentRepository _repository;
  const GetTransactionsUseCase(this._repository);

  Future<Either<Failures, List<TransactionEntity>>> call() {
    return _repository.getUserTransactions();
  }
}

