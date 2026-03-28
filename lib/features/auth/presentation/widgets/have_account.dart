import 'package:dokan/core/navigation/route_names.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../core/localization/app_localization.dart';

class HaveAccountWidget extends StatelessWidget {
  const HaveAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          AppLocalizations.of(context).translate("already_have_account"),
          style: AppTextStyles.descriptiveItems,
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.login);
          },
          icon: FaIcon(
            FontAwesomeIcons.arrowRightLong,
            color: AppColors.primary,
            size: 20,
          ),
        ),
      ],
    );
  }
}