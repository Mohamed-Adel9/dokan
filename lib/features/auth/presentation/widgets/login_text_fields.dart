import 'package:dokan/shared/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_localization.dart';

class LoginTextFields extends StatelessWidget {
  final TextEditingController  mailController  ;
  final TextEditingController passwordController ;

  const LoginTextFields({
    required this.mailController,
    required this.passwordController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthTextField(
          hint: AppLocalizations.of(context).translate("email"),
          controller: mailController,
          validator: (value){
            if(value == null || value.isEmpty){
              return "E_Mail can't be empty !!!";
            }
            return null ;
          },
        ),
        SizedBox(height: 16,),
        AuthTextField(
          hint: AppLocalizations.of(context).translate("password"),
          controller: passwordController,
          obscure: true,
          validator: (value){
            if(value == null || value.length < 6){
              return "password can't be less than 6 characters";
            }
            return null ;
          },

        ),
      ],
    );
  }
}