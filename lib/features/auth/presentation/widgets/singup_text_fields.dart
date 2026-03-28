import 'package:dokan/shared/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_localization.dart';

class SignUpTextFields extends StatelessWidget {
  final TextEditingController mailController  ;
  final TextEditingController nameController  ;
  final TextEditingController passwordController ;

  const SignUpTextFields({
    required this.mailController,
    required this.passwordController,
    required this.nameController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context) ;

    return Column(
      children: [
        AuthTextField(
          hint: locale.translate("name"),
          controller: nameController,
          obscure: false,
          validator: (value){
            if(value == null || value.isEmpty){
              return "please enter your name";
            }
            return null ;
          },

        ),
        SizedBox(height: 16,),
        AuthTextField(
          hint: locale.translate("email"),
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
          hint: locale.translate("password"),
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