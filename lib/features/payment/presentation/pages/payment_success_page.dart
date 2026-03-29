import 'package:flutter/material.dart';
import '../../domain/entitiy/transaction_entity.dart';

class PaymentSuccessPage extends StatelessWidget {
  final TransactionEntity transaction;
  const PaymentSuccessPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Success icon
              Container(
                width: 88, height: 88,
                decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle),
                child: Icon(Icons.check_rounded,
                    color: Colors.green.shade600, size: 46),
              ),
              const SizedBox(height: 20),
              const Text('Payment successful!',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(
                'EGP ${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.green.shade700),
              ),
              const SizedBox(height: 24),
              // Details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(children: [
                  _Row('Method',
                      transaction.method == PaymentMethod.card
                          ? 'Card'
                          : 'Mobile Wallet'),
                  _Row('Transaction ID',
                      transaction.transactionId ?? '—'),
                  _Row('Date',
                      '${transaction.createdAt.day}/'
                          '${transaction.createdAt.month}/'
                          '${transaction.createdAt.year}'),
                ]),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () =>
                    Navigator.of(context).popUntil((r) => r.isFirst),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Back to home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label, value;
  const _Row(this.label, this.value);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                color: Colors.grey, fontSize: 13)),
        Flexible(
          child: Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 13),
              textAlign: TextAlign.end),
        ),
      ],
    ),
  );
}