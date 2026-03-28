import 'package:dokan/core/navigation/route_names.dart';
import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/features/auth/presentation/widgets/forget_password_wiget.dart';
import 'package:dokan/features/auth/presentation/widgets/login_text_fields.dart';
import 'package:dokan/features/auth/presentation/widgets/social_login.dart';
import 'package:dokan/shared/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_localization.dart';
import 'bloc/login_cubit.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
   const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    context.read<LoginCubit>().login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.home,
                (route) => false,
            arguments: state.user,
          );
        }

        if (state is LogoutSuccess) {
          // Handle logout from anywhere
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.login,
                (route) => false,
          );
        }

        if (state is LoginError) {
          _showErrorSnackBar(context, state.message);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Header
                _buildHeader(context),

                const SizedBox(height: 40),

                // Form
                _buildForm(context),

                const SizedBox(height: 30),

                // Divider
                _buildDivider(context),

                const SizedBox(height: 20),

                // Social Login
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return SocialLogin(
                       isLoadingFace: state is LoginFaceBookLoading,
                       isLoadingGoogle: state is LoginGoogleLoading,
                    );
                  },
                ),

                const SizedBox(height: 30),

                // Sign Up
                _buildSignUpRow(context),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).translate("welcome_back"),
          style: AppTextStyles.headline2,
        ),
        Text(
          AppLocalizations.of(context).translate("login"),
          style: AppTextStyles.headline
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(

        children: [
          //  Text Fields
          LoginTextFields(
            mailController: _emailController,
            passwordController: _passwordController,
          ),

          const SizedBox(height: 8),

          // Forget Password

          ForgetPasswordWidget(),


          const SizedBox(height: 20),

          // Login Button
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return AuthButton(
                text: AppLocalizations.of(context).translate("login"),
                isLoading: state is LoginLoading,
                onPressed:_login,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            AppLocalizations.of(context).translate("login_with_social"),
            style: AppTextStyles.descriptiveItems.copyWith(
              color: Colors.grey,
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSignUpRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context).translate("don't_have_account"),
          style: AppTextStyles.descriptiveItems,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.signUp);
          },
          child: Text(
            AppLocalizations.of(context).translate("sign_up"),
            style: AppTextStyles.headline3.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  //  Helpers

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
      ),
    );
  }
}
