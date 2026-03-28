

import 'package:dokan/shared/widgets/favorite_view_builder.dart';
import 'package:flutter/material.dart';


class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                FavoriteViewBuilder(),
              ],
            ),
          );
        }
  }

