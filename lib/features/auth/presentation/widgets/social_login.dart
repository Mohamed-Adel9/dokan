import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../login/bloc/login_cubit.dart';

class SocialLogin extends StatelessWidget {
  final bool isLoadingFace;
  final bool isLoadingGoogle;
  const SocialLogin({super.key, required this.isLoadingFace,required this.isLoadingGoogle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // google button
        isLoadingGoogle
            ? Center(child: CircularProgressIndicator())
            : SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                    ),
                  ),
                  onPressed: () {
                    context.read<LoginCubit>().signInWithGoogle();
                  },
                  child: FaIcon(FontAwesomeIcons.google, size: 30),
                ),
              ),
        SizedBox(width: 60),

        //facebook icon
        isLoadingFace
            ? Center(child: CircularProgressIndicator())
            : SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                    ),
                  ),
                  onPressed: () {
                    context.read<LoginCubit>().signInWithFacebook();
                  },
                  child: FaIcon(FontAwesomeIcons.facebook, size: 30),
                ),
              ),
      ],
    );
  }
}
