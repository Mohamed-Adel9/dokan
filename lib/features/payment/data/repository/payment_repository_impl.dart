import 'package:dartz/dartz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entitiy/transaction_entity.dart';
import '../../domain/failure/payment_initailzation_failure.dart'
    hide NetworkFailure;
import '../../domain/repository/payment_repository.dart';
import '../data_source/payment_local_data_source.dart';
import '../data_source/payment_remote_data_source.dart';
import '../models/transaction_model.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource _remote;
  final PaymentLocalDataSource _local;
  final Connectivity _connectivity;

  final user = FirebaseAuth.instance.currentUser!.uid;

   PaymentRepositoryImpl({
    required PaymentRemoteDataSource remote,
    required PaymentLocalDataSource local,
    required Connectivity connectivity,
  }) : _remote = remote,
       _local = local,
       _connectivity = connectivity;

  Future<bool> get _isOnline async {
    final r = await _connectivity.checkConnectivity();
    return r.first != ConnectivityResult.none;
  }

  @override
  Future<Either<Failures, TransactionEntity>> saveTransaction({
    required double amount,
    required String currency,
    required PaymentMethod method,
    required PaymentStatus status,
    String? paymobTransactionId,
    String? failureReason,
  }) async {
    try {
      if (!await _isOnline) return Left(NetworkFailure("Network Issue~!"));

      final model = TransactionModel(
        id: '',
        userId: user,
        amount: amount,
        currency: currency,
        method: method,
        status: status,
        transactionId: paymobTransactionId,
        failureReason: failureReason,
        createdAt: DateTime.now(),
      );
      final saved = await _remote.saveTransaction(model);
      return Right(saved);
    } catch (e) {
      return Left(SaveTransactionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<TransactionEntity>>>
  getUserTransactions() async {
    try {
      if (!await _isOnline) {
        final cached = await _local.getCachedTransactions();
        return Right(cached);
      }
      final list = await _remote.getUserTransactions();
      await _local.cacheTransactions(list); // update cache
      return Right(list);
    } catch (e) {
      // Fallback to cache on any error
      try {
        final cached = await _local.getCachedTransactions();
        if (cached.isNotEmpty) return Right(cached);
      } catch (_) {}
      return Left(FetchTransactionsFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, TransactionEntity>> getTransactionById(
    String id,
  ) async {
    try {
      final tx = await _remote.getTransactionById(id);
      return Right(tx);
    } catch (e) {
      return Left(FetchTransactionsFailure(e.toString()));
    }
  }
}
