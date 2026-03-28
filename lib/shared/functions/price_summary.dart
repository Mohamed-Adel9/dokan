import 'package:flutter/material.dart';

import '../../core/localization/app_localization.dart';
import '../../core/theme/app_text_styles.dart';

class PriceSummary extends StatelessWidget {
  final double subtotal;
  final double totalAfterDiscount;
  final double delivery;

  const PriceSummary({
    super.key,
    required this.subtotal,
    required this.delivery,
    required this.totalAfterDiscount,
  });

  @override
  Widget build(BuildContext context) {
    final total = totalAfterDiscount + delivery;
    final locale = AppLocalizations.of(context) ;
    return Column(
      children: [
        Container(height: 1, width: double.infinity, color: Colors.grey),

        const SizedBox(height: 12),

        _priceRow(context,locale.translate("total_price"), subtotal),
        _priceRow(context,locale.translate("total_price_after_discount"), totalAfterDiscount),
        _priceRow(context,locale.translate("delivery"), delivery),
        _priceRow(context,locale.translate("total"), total),
      ],
    );
  }
  Widget _priceRow(BuildContext context,String title, num price) {
    final locale = AppLocalizations.of(context) ;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title :", style: AppTextStyles.subheads),
          Text("${locale.translate("egp")} $price", style: AppTextStyles.subheads),
        ],
      ),
    );
  }

}
