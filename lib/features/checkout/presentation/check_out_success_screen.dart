import 'package:dokan/core/localization/app_localization.dart';
import 'package:dokan/core/navigation/route_names.dart';
import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/shared/widgets/auth_button.dart';
import 'package:flutter/material.dart';

class CheckOutSuccessScreen extends StatelessWidget {
  const CheckOutSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/bags.png"),
            Column(
              children: [
                Text(locale.translate("success"), style: AppTextStyles.headline),
                Text(
                  locale.translate("order_success"),
                  style: AppTextStyles.regular,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              child: AuthButton(text: locale.translate("continue_shopping"), onPressed: () {
                Navigator.pushReplacementNamed(context, RouteNames.home);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
