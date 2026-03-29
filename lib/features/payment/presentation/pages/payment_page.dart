import 'package:dokan/features/payment/presentation/pages/payment_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/payment_cubit.dart';
import '../bloc/payment_states.dart';
import '../widgets/payment_method_tile.dart';

enum _Method { card, wallet }

class PaymentPage extends StatefulWidget {
  final double orderAmount;
  const PaymentPage({super.key, required this.orderAmount});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  _Method _selected = _Method.card;
  final _phoneCtrl  = TextEditingController();
  final _formKey    = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<PaymentCubit>(),
      child: BlocConsumer<PaymentCubit, PaymentState>(
        listener: _listener,
        builder:  _builder,
      ),
    );
  }

  void _listener(BuildContext ctx, PaymentState state) {
    if (state is PaymentSuccess) {
      Navigator.pushReplacement(ctx, MaterialPageRoute(
        builder: (_) =>
            PaymentSuccessPage(transaction: state.transaction),
      ));
    } else if (state is PaymentFailure) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(state.message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
      ));
      ctx.read<PaymentCubit>().reset();
    }
  }

  Widget _builder(BuildContext ctx, PaymentState state) {
    final loading = state is PaymentLoading;
    return Scaffold(
      appBar: AppBar(
          title: const Text('Checkout'), centerTitle: true),
      body: Form(
        key: _formKey,
        child: ListView(padding: const EdgeInsets.all(20),
          children: [
            // Order total
            _SummaryCard(amount: widget.orderAmount),
            const SizedBox(height: 24),
            const Text('Payment method',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            // Card tile
            PaymentMethodTile(
              icon: Icons.credit_card_rounded,
              label: 'Credit / Debit card',
              subtitle: 'Visa · Mastercard',
              selected: _selected == _Method.card,
              onTap: () => setState(() => _selected = _Method.card),
            ),
            const SizedBox(height: 10),

            // Wallet tile
            PaymentMethodTile(
              icon: Icons.account_balance_wallet_rounded,
              label: 'Mobile wallet',
              subtitle: 'Vodafone Cash · Orange · Etisalat · WE',
              selected: _selected == _Method.wallet,
              onTap: () =>
                  setState(() => _selected = _Method.wallet),
            ),

            // Phone field — wallet only
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: _selected == _Method.wallet
                  ? Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Wallet phone number',
                    hintText: '010xxxxxxxx',
                    prefixIcon: Icon(Icons.phone_rounded),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (_selected != _Method.wallet)
                      return null;
                    if (v == null || v.trim().isEmpty)
                      return 'Enter your wallet number';
                    if (!RegExp(r'^01[0-9]{9}$')
                        .hasMatch(v.trim()))
                      return 'Enter a valid Egyptian number';
                    return null;
                  },
                ),
              )
                  : const SizedBox.shrink(),
            ),

            const SizedBox(height: 32),

            // Pay button
            FilledButton(
              onPressed: loading ? null : () => _submit(ctx),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: loading
                  ? const SizedBox(
                  width: 22, height: 22,
                  child: CircularProgressIndicator(
                      strokeWidth: 2.5, color: Colors.white))
                  : Text(
                  'Pay EGP ${widget.orderAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext ctx) {
    if (!_formKey.currentState!.validate()) return;
    final cubit = ctx.read<PaymentCubit>();
    if (_selected == _Method.card) {
      cubit.payWithCard(context: ctx, amount: widget.orderAmount);
    } else {
      cubit.payWithWallet(
          context: ctx,
          amount: widget.orderAmount,
          phoneNumber: _phoneCtrl.text.trim());
    }
  }

  @override
  void dispose() { _phoneCtrl.dispose(); super.dispose(); }
}

class _SummaryCard extends StatelessWidget {
  final double amount;
  const _SummaryCard({required this.amount});
  @override
  Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(
          color: Theme.of(ctx).colorScheme.outlineVariant),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Order total'),
        Text('EGP ${amount.toStringAsFixed(2)}',
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700)),
      ],
    ),
  );
}