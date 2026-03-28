import 'package:flutter/material.dart';

import '../../core/localization/app_localization.dart';
import '../../core/theme/app_text_styles.dart';

Widget paymentWidget(BuildContext context, String paymentMethod) {
  final locale = AppLocalizations.of(context);

  switch (paymentMethod) {
    case "cash":
      return _paymentTile(
        "assets/images/checkout/cash.png",
        locale.translate("cash_title"),
        locale.translate("cash_subtitle"),
      );

    case "card":
      return _paymentTile(
        "assets/images/checkout/card.png",
        locale.translate("card_title"),
        locale.translate("card_subtitle"),
      );

    case "vodafone":
      return _paymentTile(
        "assets/images/checkout/vodafone.png",
        locale.translate("wallet_title"),
        locale.translate("wallet_subtitle"),
      );

    default:
      return const SizedBox();
  }
}

Widget _paymentTile(String image, String title, String subtitle) {
  return Row(
    children: [
      Image.asset(image, height: 45),
      SizedBox(width: 15,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.descriptiveItems),
          Text(subtitle, style: AppTextStyles.helperText),
        ],
      ),
    ],
  );
}