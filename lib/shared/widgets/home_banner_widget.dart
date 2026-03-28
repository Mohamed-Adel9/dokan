import 'package:flutter/material.dart';

import '../../core/theme/app_text_styles.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,

        children: [
          Image.network(
            "https://picsum.photos/300/200",
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Street Cloths", style: AppTextStyles.headline),
            ),
          ),
        ],
      ),
    );
  }
}