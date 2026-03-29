import 'dart:convert';
import 'package:hive/hive.dart';
import '../../domain/entitiy/transaction_entity.dart';
import '../models/transaction_model.dart';

abstract class PaymentLocalDataSource {
  Future<void> cacheTransactions(List<TransactionModel> list);
  Future<List<TransactionModel>> getCachedTransactions();
  Future<void> clearCache();
}

class PaymentLocalDataSourceImpl implements PaymentLocalDataSource {
  static const _boxName  = 'payment_cache';
  static const _cacheKey = 'transactions';

  Future<Box> get _box async => Hive.isBoxOpen(_boxName)
      ? Hive.box(_boxName)
      : await Hive.openBox(_boxName);

  @override
  Future<void> cacheTransactions(
      List<TransactionModel> transactions) async {
    final box = await _box;
    final encoded = transactions.map((t) {
      final map = t.toFirestore();
      map['id']        = t.id;
      map['createdAt'] = t.createdAt.toIso8601String();
      return jsonEncode(map);
    }).toList();
    await box.put(_cacheKey, encoded);
  }

  @override
  Future<List<TransactionModel>> getCachedTransactions() async {
    final box  = await _box;
    final data = box.get(_cacheKey) as List<dynamic>?;
    if (data == null) return [];
    return data.map((e) {
      final m = jsonDecode(e as String) as Map<String, dynamic>;
      return TransactionModel(
        id:            m['id']        as String,
        userId:        m['userId']    as String,
        amount:        (m['amount']  as num).toDouble(),
        currency:      m['currency'] as String,
        method:        PaymentMethod.values.byName(m['method']),
        status:        PaymentStatus.values.byName(m['status']),
        transactionId: m['transactionId'] as String?,
        failureReason: m['failureReason'] as String?,
        createdAt:     DateTime.parse(m['createdAt'] as String),
      );
    }).toList();
  }

  @override
  Future<void> clearCache() async {
    final box = await _box;
    await box.delete(_cacheKey);
  }
}