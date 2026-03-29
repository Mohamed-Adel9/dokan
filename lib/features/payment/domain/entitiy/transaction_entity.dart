class TransactionEntity {
  final String id;
  final String userId;
  final double amount;
  final String currency;
  final PaymentMethod method;
  final PaymentStatus status;
  final String? transactionId;  // Paymob transaction ID
  final String? failureReason;
  final DateTime createdAt;

  const TransactionEntity({
    required this.id,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.method,
    required this.status,
    this.transactionId,
    this.failureReason,
    required this.createdAt,
  });
}

enum PaymentMethod { card, wallet }

enum PaymentStatus { pending, success, failed }