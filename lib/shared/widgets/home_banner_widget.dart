import 'package:dokan/core/localization/app_localization.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_text_styles.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,

        children: [
          Image.network(
            "https://res.cloudinary.com/dsjo1n46k/image/upload/q_auto/f_auto/v1775126227/saleandoffer_guhlhz.jpg",
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(AppLocalizations.of(context).translate('big_sale'), style: AppTextStyles.headline),
            ),
          ),
        ],
      ),
    );
  }
}
