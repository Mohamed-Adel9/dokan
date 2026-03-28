import 'dart:async';

import 'package:dokan/core/navigation/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../auth/domain/entities/user.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {


  void _startDelay() {
     Timer(const Duration(microseconds: 4000), _goNext);
  }

  void _goNext() {

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {

      final userEntity = UserEntity(
        id: user.uid,
        email: user.email ?? "",
        name: user.displayName ?? "m",
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.home,
            (route) => false,
        arguments: userEntity,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.login,
            (route) => false,
      );
    }
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.asset("assets/images/logo.png"),)
      ],
    );
  }
}