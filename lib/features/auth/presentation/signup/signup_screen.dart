import 'package:dokan/core/navigation/route_names.dart';
import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/features/auth/presentation/login/bloc/login_state.dart';
import 'package:dokan/features/auth/presentation/signup/bloc/signup_cubit.dart';
import 'package:dokan/features/auth/presentation/widgets/have_account.dart';
import 'package:dokan/features/auth/presentation/widgets/singup_text_fields.dart';
import 'package:dokan/features/auth/presentation/widgets/social_login.dart';
import 'package:dokan/shared/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localization.dart';
import 'bloc/signup_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (!_formKey.currentState!.validate()) return;
    context.read<SignupCubit>().signup(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.home,
                (route) => false,
            arguments: state.userEntity,
          );
        }
        if (state is SignUpErrorState) {
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
                const SizedBox(height: 10),


                _buildHeader(context, locale),

                const SizedBox(height: 30),

                // ── Form ──────────────────────────────────────────────
                _buildForm(context, locale),

                const SizedBox(height: 24),

                // ── Divider ───────────────────────────────────────────
                _buildDivider(context, locale),

                const SizedBox(height: 20),

                // ── Social Login ──────────────────────────────────────
                BlocBuilder<SignupCubit, SignupState>(
                  builder: (context, state) {
                    return SocialLogin(
                      isLoadingFace: state is LoginFaceBookLoading,
                      isLoadingGoogle: state is LoginGoogleLoading,
                    );
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Widgets ───────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context, AppLocalizations locale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          locale.translate('sign_up'),
          style: AppTextStyles.headline,
        ),

        const SizedBox(height: 8),

        // ✅ Subtitle for better UX
        Text(
          locale.translate('sign_up_subtitle'),
          style: AppTextStyles.descriptiveItems.copyWith(
            color: Colors.grey,
            height: 1.5,
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
          // ── Text Fields ───────────────────────────────────────────
          SignUpTextFields(
            nameController: _nameController,
            mailController: _emailController,
            passwordController: _passwordController,
          ),

          const SizedBox(height: 8),

          // ── Have Account ──────────────────────────────────────────
          HaveAccountWidget(),

          const SizedBox(height: 20),

          // ── Sign Up Button ────────────────────────────────────────
          BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              return AuthButton(
                text: locale.translate('sign_up'),
                isLoading: state is SignUpLoadingState,
                onPressed: _signUp,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context, AppLocalizations locale) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            locale.translate('sign_up_with_social'),
            style: AppTextStyles.descriptiveItems.copyWith(
              color: Colors.grey,
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────

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
        behavior: SnackBarBehavior.floating, // ✅ Looks better
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}