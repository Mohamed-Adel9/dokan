import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/localization/app_localization.dart';
import '../../features/home/presentation/home/bloc/home_cubit.dart';
import '../../features/home/presentation/home/bloc/home_states.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return BlocBuilder<BottomNavCubit, HomeBottomNavState>(
      builder: (context, state) {
        final cubit = context.read<BottomNavCubit>();
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(10, 5),
                blurRadius: 5,
              ),
            ],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 17,
            selectedIconTheme: IconThemeData(size: 30),
            currentIndex: state.index,
            onTap: cubit.changeTap,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: locale.translate('home')),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: locale.translate('shopping'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: locale.translate('bag'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: locale.translate('favorite'),
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.user),
                label: locale.translate('profile'),
              ),
            ],
          ),
        );
      },
    );
  }
}
