import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/localization/bloc/locale_cubit.dart';
import 'core/theme/theme_cubit.dart';
import 'core/theme/app_theme.dart';
import 'core/navigation/app_router.dart';
import 'core/navigation/route_names.dart';
import 'core/localization/app_localization_delegate.dart';

class DokanAppScreen extends StatelessWidget {
  const DokanAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocaleCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Dokan App',

                // 🌍 Localization
                localizationsDelegates: const [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
                ],
                locale: locale,

                // 🚦 Navigation
                initialRoute: RouteNames.splash,
                onGenerateRoute: AppRouter.generateRoute,

                // 🎨 Theme
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: themeMode,

                builder: (context, child) {
                  return AnimatedTheme(
                    data: themeMode == ThemeMode.dark
                        ? AppTheme.dark
                        : AppTheme.light,
                    duration: const Duration(milliseconds: 400),
                    child: child!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}