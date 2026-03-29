


import '../../domain/entitiy/transaction_entity.dart';

sealed class PaymentState {}

// ── Checkout states ──────────────────────────────
final class PaymentInitial   extends PaymentState {}
final class PaymentLoading   extends PaymentState {}
final class PaymentCancelled extends PaymentState {}

final class PaymentSuccess extends PaymentState {
  final TransactionEntity transaction;
  PaymentSuccess(this.transaction);
}

final class PaymentFailure extends PaymentState {
  final String message;
  PaymentFailure(this.message);
}

// ── Transaction history states ───────────────────
final class TransactionsLoading extends PaymentState {}

final class TransactionsLoaded extends PaymentState {
  final List<TransactionEntity> transactions;
  TransactionsLoaded(this.transactions);
}

final class TransactionsError extends PaymentState {
  final String message;
  TransactionsError(this.message);
}