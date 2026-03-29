import 'package:dokan/app.dart';
import 'package:dokan/core/app_initializer.dart';
import 'package:dokan/core/di/service_locator.dart';
import 'package:dokan/features/auth/presentation/login/bloc/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.init();

  runApp(BlocProvider(
    create: (_) => sl<LoginCubit>(),
    child: DokanApp(),
  ));
}

class DokanApp extends StatelessWidget {


  const DokanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DokanAppScreen();
  }
}
