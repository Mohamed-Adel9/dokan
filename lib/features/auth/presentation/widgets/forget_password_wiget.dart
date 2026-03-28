import 'package:dokan/core/navigation/route_names.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../core/localization/app_localization.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.forgetPassword);
          },
          icon: FaIcon(
            FontAwesomeIcons.arrowRightLong,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        Text(
          AppLocalizations.of(context).translate("forget_your_password"),
          style: AppTextStyles.descriptiveItems,
        ),
      ],
    );
  }
}
