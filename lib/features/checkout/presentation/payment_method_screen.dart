import 'package:dokan/core/localization/app_localization.dart';
import 'package:dokan/shared/widgets/auth_button.dart';
import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = 'cash';



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
    return Scaffold(
      appBar: AppBar(
        title:  Text(locale.translate("payment_method")),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: paymentMethods.length,
                separatorBuilder: (_, _) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final method = paymentMethods[index];
                  final isSelected = selectedMethod == method["value"];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMethod = method["value"];
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isSelected
                              ? Colors.grey.shade300
                              : Colors.black,
                          width: isSelected ? 1.8 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 52,
                            width: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Image.asset(
                              method["image"],
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                            onTap: () {
                              setState(() {
                                selectedMethod = method["value"];
                              });
                            },
                            child: Icon(
                              selectedMethod == method["value"]
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: selectedMethod == method["value"]
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
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
            SizedBox(
              width: double.infinity,
              height: 56,
              child: AuthButton(text: locale.translate("continue"), onPressed:  () {
                Navigator.pop(context, selectedMethod);
            },),
            ),
          ],
        ),
      ),
    );
  }
}