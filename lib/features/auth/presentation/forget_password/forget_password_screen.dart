import 'package:dokan/core/theme/app_colors.dart';
import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/shared/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localization.dart';
import '../../../../shared/widgets/auth_text_field.dart';
import 'bloc/forget_password_cubit.dart';
import 'bloc/forget_password_state.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _forgetPassword() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ForgetPasswordCubit>().forgetPassword(
      _emailController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          _showSuccessDialog(context, locale);
        }
        if (state is ForgetPasswordError) {
          _showErrorSnackBar(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),


                _buildHeader(context, locale),

                const SizedBox(height: 50),

                _buildForm(context, locale),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widgets

  Widget _buildHeader(BuildContext context, AppLocalizations locale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.lock_reset_rounded,
            size: 40,
            color: Theme.of(context).primaryColor,
          ),
        ),

        const SizedBox(height: 24),

        Text(
          locale.translate("forget_password"),
          style: AppTextStyles.headline,
        ),

        const SizedBox(height: 12),

        Text(
          locale.translate("forget_password_text"),
          style: AppTextStyles.descriptionText.copyWith(
            color: AppColors.grey,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context, AppLocalizations locale) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // ── Email Field ───────────────────────────────────────────
          AuthTextField(
            hint: locale.translate("email"),
            controller: _emailController,

            validator: (value) {
              if (value == null || value.isEmpty) {
                return locale.translate("email_required");
              }
              // ✅ Proper email validation

              return null;
            },
          ),

          const SizedBox(height: 32),

          // Send Button
          BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
            builder: (context, state) {
              return AuthButton(
                text: locale.translate("send"),
                isLoading: state is ForgetPasswordLoading,
                onPressed: _forgetPassword,
              );
            },
          ),

          const SizedBox(height: 20),

          // Back to Login
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                locale.translate("remember_password"),
                style: AppTextStyles.descriptiveItems,
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  locale.translate("login"),
                  style: AppTextStyles.headline3.copyWith(
                    fontWeight: FontWeight.bold,

                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helpers

  void _showSuccessDialog(BuildContext context, AppLocalizations locale) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Success animation icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mark_email_read_outlined,
                color: Colors.green,
                size: 50,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              locale.translate("email_sent"),
              style: AppTextStyles.headline2,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              locale.translate("check_email"),
              style: AppTextStyles.descriptiveItems.copyWith(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // ✅ Go back to login after success
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to login
                },
                child: Text(locale.translate("back_to_login")),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}