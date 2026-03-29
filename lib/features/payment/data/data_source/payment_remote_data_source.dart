import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/transaction_model.dart';

abstract class PaymentRemoteDataSource {
  Future<TransactionModel> saveTransaction(TransactionModel model);
  Future<List<TransactionModel>> getUserTransactions();
  Future<TransactionModel> getTransactionById(String id);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  const PaymentRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  // Current user's transactions collection
  CollectionReference<Map<String, dynamic>> get _txCol {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('transactions');
  }

  @override
  Future<TransactionModel> saveTransaction(
      TransactionModel model) async {
    final ref  = await _txCol.add(model.toFirestore());
    final snap = await ref.get();
    return TransactionModel.fromFirestore(snap);
  }

  @override
  Future<List<TransactionModel>> getUserTransactions() async {
    final snap = await _txCol
        .orderBy('createdAt', descending: true)
        .get();
    return snap.docs
        .map((d) => TransactionModel.fromFirestore(d))
        .toList();
  }

  @override
  Future<TransactionModel> getTransactionById(String id) async {
    final snap = await _txCol.doc(id).get();
    if (!snap.exists) throw Exception('Transaction not found');
    return TransactionModel.fromFirestore(snap);
  }
}