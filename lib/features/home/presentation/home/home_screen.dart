import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../shared/widgets/bottom_navbar_widget.dart';
import 'bloc/home_cubit.dart';
import 'bloc/home_states.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, HomeBottomNavState>(
      builder: (context, state) {
        final cubit = context.read<BottomNavCubit>();
        final userName = cubit.user;
        return Scaffold(
          appBar: AppBar(
            title: Text("${AppLocalizations.of(context).translate('hello')}, $userName"),
            actions: [
              IconButton(
                icon: Icon(
                  context.read<ThemeCubit>().isDark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                onPressed: () {
                  final cubit = context.read<ThemeCubit>();

                  if (cubit.isDark) {
                    cubit.setLight();
                  } else {
                    cubit.setDark();
                  }
                },
              )
            ],
            titleTextStyle: AppTextStyles.headline3,
          ),
          body: cubit.pages[state.index],
          bottomNavigationBar: BottomNavigationBarWidget(),
        );
      },
    );
  }
}
