import 'package:dokan/shared/widgets/auth_button.dart';
import 'package:flutter/material.dart';

import '../../../core/localization/app_localization.dart';
import '../../../core/navigation/route_names.dart';

class WriteCommentButton extends StatelessWidget {
  const WriteCommentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AuthButton(
        text: AppLocalizations.of(context).translate('write_comment'),
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.rate);
        },
      ),
    );
  }
}
