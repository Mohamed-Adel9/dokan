import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entitiy/transaction_entity.dart';
import '../bloc/payment_cubit.dart';
import '../bloc/payment_states.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      GetIt.I<PaymentCubit>()..loadTransactions(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Transaction history')),
        body: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if (state is TransactionsLoading) {
              return const Center(
                  child: CircularProgressIndicator());
            }
            if (state is TransactionsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: Colors.red),
                    const SizedBox(height: 12),
                    Text(state.message),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () => context
                          .read<PaymentCubit>()
                          .loadTransactions(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state is TransactionsLoaded) {
              if (state.transactions.isEmpty) {
                return const Center(
                    child: Text('No transactions yet'));
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.transactions.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: 10),
                itemBuilder: (_, i) =>
                    _TxCard(state.transactions[i]),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _TxCard extends StatelessWidget {
  final TransactionEntity tx;
  const _TxCard(this.tx);
  @override
  Widget build(BuildContext context) {
    final ok = tx.status == PaymentStatus.success;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: [
        Container(
          width: 42, height: 42,
          decoration: BoxDecoration(
            color: ok ? Colors.green.shade50 : Colors.red.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            tx.method == PaymentMethod.card
                ? Icons.credit_card_rounded
                : Icons.account_balance_wallet_rounded,
            color: ok
                ? Colors.green.shade600
                : Colors.red.shade400,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tx.method == PaymentMethod.card
                  ? 'Card payment' : 'Wallet payment',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              '${tx.createdAt.day}/${tx.createdAt.month}/${tx.createdAt.year}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        )),
        Column(crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('EGP ${tx.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 15)),
              Text(ok ? 'Success' : 'Failed',
                  style: TextStyle(
                      fontSize: 12,
                      color: ok
                          ? Colors.green.shade600
                          : Colors.red.shade500)),
            ]),
      ]),
    );
  }
}