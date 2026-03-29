import 'package:dokan/core/errors/failures.dart';

class PaymentInitializationFailure extends Failures {
  const PaymentInitializationFailure(
      [super.message = 'Failed to initialize payment']);
}

class PaymentCancelledFailure extends Failures {
  const PaymentCancelledFailure(
      [super.message = 'Payment was cancelled']);
}

class PaymentDeclinedFailure extends Failures {
  const PaymentDeclinedFailure(super.reason);
}

class SaveTransactionFailure extends Failures {
  const SaveTransactionFailure(
      [super.message = 'Failed to save transaction']);
}

class FetchTransactionsFailure extends Failures {
  const FetchTransactionsFailure(
      [super.message = 'Failed to fetch transactions']);
}

class NetworkFailure extends Failures {
  const NetworkFailure(
      [super.message = 'No internet connection']);
}