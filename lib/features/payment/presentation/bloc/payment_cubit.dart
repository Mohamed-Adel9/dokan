import 'package:dokan/features/payment/presentation/bloc/payment_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_transactions_use_case.dart';
import '../../domain/usecases/pay_with_card_use_case.dart';
import '../../domain/usecases/pay_with_wallet_use_case.dart';


class PaymentCubit extends Cubit<PaymentState> {
  final PayWithCardUseCase     _payWithCard;
  final PayWithWalletUseCase   _payWithWallet;
  final GetTransactionsUseCase _getTransactions;

  PaymentCubit({
    required PayWithCardUseCase     payWithCard,
    required PayWithWalletUseCase   payWithWallet,
    required GetTransactionsUseCase getTransactions,
  })  : _payWithCard     = payWithCard,
        _payWithWallet   = payWithWallet,
        _getTransactions = getTransactions,
        super(PaymentInitial());

  // ── Card payment ──────────────────────────────
  Future<void> payWithCard({
    required BuildContext context,
    required double amount,
    String currency = 'EGP',
  }) async {
    emit(PaymentLoading());
    final result = await _payWithCard(
      context: context, amount: amount, currency: currency,
    );
    result.fold(
          (f) => emit(PaymentFailure(f.massage)),
          (t) => emit(PaymentSuccess(t)),
    );
  }

  // ── Wallet payment ────────────────────────────
  Future<void> payWithWallet({
    required BuildContext context,
    required double amount,
    required String phoneNumber,
    String currency = 'EGP',
  }) async {
    emit(PaymentLoading());
    final result = await _payWithWallet(
      context:     context,
      amount:      amount,
      currency:    currency,
      phoneNumber: phoneNumber,
    );
    result.fold(
          (f) => emit(PaymentFailure(f.massage)),
          (t) => emit(PaymentSuccess(t)),
    );
  }

  // ── Load history ──────────────────────────────
  Future<void> loadTransactions() async {
    emit(TransactionsLoading());
    final result = await _getTransactions();
    result.fold(
          (f) => emit(TransactionsError(f.massage)),
          (l) => emit(TransactionsLoaded(l)),
    );
  }

  void reset() => emit(PaymentInitial());
}