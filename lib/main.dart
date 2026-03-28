import 'package:dokan/core/di/service_locator.dart';
import 'package:dokan/core/localization/bloc/locale_cubit.dart';
import 'package:dokan/core/navigation/app_router.dart';
import 'package:dokan/core/navigation/route_names.dart';
import 'package:dokan/core/theme/app_theme.dart';
import 'package:dokan/core/theme/theme_cubit.dart';
import 'package:dokan/features/auth/presentation/login/bloc/login_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/localization/app_localization_delegate.dart';
import 'firebase_options.dart' show DefaultFirebaseOptions;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init(); // get it
  await Hive.initFlutter(); // hive

  runApp(BlocProvider(
    create: (_) => sl<LoginCubit>(),
    child: DokanApp(),
  ));
}

class DokanApp extends StatelessWidget {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  DokanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocaleCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
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
                // default

                initialRoute: RouteNames.splash,
                onGenerateRoute: AppRouter.generateRoute,
                title: 'Dokan App',
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
