import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entitiy/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.id,
    required super.userId,
    required super.amount,
    required super.currency,
    required super.method,
    required super.status,
    super.transactionId,
    super.failureReason,
    required super.createdAt,
  });

  // Firestore snapshot → Model
  factory TransactionModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final d = doc.data()!;
    return TransactionModel(
      id: doc.id,
      userId: d['userId'] as String,
      amount: (d['amount'] as num).toDouble(),
      currency: d['currency'] as String,
      method: PaymentMethod.values.byName(d['method'] as String),
      status: PaymentStatus.values.byName(d['status'] as String),
      transactionId: d['transactionId'] as String?,
      failureReason: d['failureReason'] as String?,
      createdAt: (d['createdAt'] as Timestamp).toDate(),
    );
  }

  // Model → Firestore map
  Map<String, dynamic> toFirestore() => {
    'userId': userId,
    'amount': amount,
    'currency': currency,
    'method': method.name,
    'status': status.name,
    'transactionId': transactionId,
    'failureReason': failureReason,
    'createdAt': FieldValue.serverTimestamp(),
  };
}
