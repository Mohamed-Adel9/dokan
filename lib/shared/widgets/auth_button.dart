import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback ? onPressed;
  final bool isLoading;


  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: double.infinity,
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: AppTextStyles.regular,
          elevation: 3,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const CircularProgressIndicator(
            color: Colors.white,
        )
            : Text(text),
      ),
    );
  }
}
