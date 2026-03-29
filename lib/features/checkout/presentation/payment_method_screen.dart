import 'package:dokan/core/localization/app_localization.dart';
import 'package:dokan/shared/widgets/auth_button.dart';
import 'package:dokan/features/payment/presentation/bloc/payment_cubit.dart';
import 'package:dokan/features/payment/presentation/pages/payment_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/service_locator.dart';
import '../../payment/presentation/bloc/payment_states.dart';

class PaymentMethodScreen extends StatefulWidget {
  final double orderAmount; // pass this from your cart/order screen
  const PaymentMethodScreen({super.key, required this.orderAmount});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = 'cash';
  final _phoneCtrl = TextEditingController();

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    final List<Map<String, dynamic>> paymentMethods = [
      {
        "title": locale.translate("cash_title"),
        "subtitle": locale.translate("cash_subtitle"),
        "value": "cash",
        "image": "assets/images/checkout/cash.png",
      },
      {
        "title": locale.translate("card_title"),
        "subtitle": locale.translate("card_subtitle"),
        "value": "card",
        "image": "assets/images/checkout/card.png",
      },
      {
        "title": locale.translate("wallet_title"),
        "subtitle": locale.translate("wallet_subtitle"),
        "value": "vodafone",
        "image": "assets/images/checkout/vodafone.png",
      },
    ];

    return BlocProvider(
      create: (_) => sl<PaymentCubit>(),
      child: BlocListener<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    PaymentSuccessPage(transaction: state.transaction),
              ),
            );
          } else if (state is PaymentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red.shade700,
                behavior: SnackBarBehavior.floating,
              ),
            );
            context.read<PaymentCubit>().reset();
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text(locale.translate("payment_method")),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: paymentMethods.length,
                        separatorBuilder: (_, _) =>
                        const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final method = paymentMethods[index];
                          final isSelected =
                              selectedMethod == method["value"];

                          return GestureDetector(
                            onTap: () => setState(
                                    () => selectedMethod = method["value"]),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.grey.shade300,
                                  width: isSelected ? 1.8 : 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 52,
                                        width: 52,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(14),
                                        ),
                                        child: Image.asset(
                                          method["image"],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              method["title"],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              method["subtitle"],
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => setState(() =>
                                        selectedMethod = method["value"]),
                                        child: Icon(
                                          isSelected
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_off,
                                          color: isSelected
                                              ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                              : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Phone field — wallet only
                                  if (isSelected &&
                                      method["value"] == "vodafone")
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 14),
                                      child: TextField(
                                        controller: _phoneCtrl,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          labelText: locale.translate(
                                              "wallet_phone_number"),
                                          hintText: '010xxxxxxxx',
                                          prefixIcon: const Icon(
                                              Icons.phone_rounded),
                                          border:
                                          const OutlineInputBorder(),
                                          contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 10),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Continue button
                    BlocBuilder<PaymentCubit, PaymentState>(
                      builder: (context, state) {
                        final isLoading = state is PaymentLoading;
                        return SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: AuthButton(
                            text: isLoading
                                ? ''
                                : locale.translate("continue"),
                            onPressed: isLoading
                                ? null
                                : () => _onContinue(context),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onContinue(BuildContext context) {
    final cubit = context.read<PaymentCubit>();

    switch (selectedMethod) {
      case 'card':
        cubit.payWithCard(
          context: context,
          amount: widget.orderAmount,
        );
        break;

      case 'vodafone':
        final phone = _phoneCtrl.text.trim();
        if (phone.isEmpty || !RegExp(r'^01[0-9]{9}$').hasMatch(phone)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Enter a valid Egyptian wallet number'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          return;
        }
        cubit.payWithWallet(
          context: context,
          amount: 1,
          phoneNumber: phone,
        );
        break;

      case 'cash':
      // Cash needs no Paymob — just pop back with the result
        Navigator.pop(context, 'cash');
        break;
    }
  }
}