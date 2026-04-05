import 'package:dokan/core/navigation/route_names.dart';
import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/app_localization.dart';
import '../../../../core/localization/bloc/locale_cubit.dart';
import '../../../../shared/widgets/profile_tile.dart';
import '../../../auth/presentation/login/bloc/login_cubit.dart';
import '../../../auth/presentation/login/bloc/login_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userName = currentUser?.displayName ??
        currentUser?.email?.split('@').first ??
        'User';
    final userEmail = currentUser?.email ?? 'No email';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Bar
          Text(
            AppLocalizations.of(context).translate('my_profile'),
            style: AppTextStyles.headline,
          ),

          const SizedBox(height: 30),

          /// User Info
          _buildUserInfo(userName, userEmail),

          const SizedBox(height: 30),

          /// Menu Items
          Expanded(
            child: ListView(
              children: [
                ProfileTile(
                  title: "Shipping addresses",
                  subtitle: "3 addresses",
                  onPressed: () {},
                ),
                ProfileTile(
                  title: "Payment methods",
                  subtitle: "Visa  **34",
                  onPressed: () {},
                ),

                ProfileTile(
                  title: "Settings",
                  subtitle: "Notifications, password",
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.setting);
                  },
                ),
              ],
            ),
          ),

          /// Bottom Section
          _buildBottomSection(context),
        ],
      ),
    );
  }

  // ── Widgets ─────────────────────────────────────────────────────────

  Widget _buildUserInfo(String userName, String userEmail) {
    return Row(
      children: [
        // ✅ Show first letter of name as avatar
        CircleAvatar(
          radius: 28,
          child: Text(
            userName[0].toUpperCase(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded( // ✅ Prevents overflow on long names
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: AppTextStyles.headline3,
                overflow: TextOverflow.ellipsis, // ✅ Handle long names
              ),
              const SizedBox(height: 4),
              Text(
                userEmail,
                style: AppTextStyles.descriptionText,
                overflow: TextOverflow.ellipsis, // ✅ Handle long emails
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Column(
      children: [
        // ── Language Selector ──────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(AppLocalizations.of(context).translate('set_language')),
            DropdownButton<String>(
              value: context.watch<LocaleCubit>().state.languageCode,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'ar', child: Text('العربية')),
              ],
              onChanged: (value) {
                context.read<LocaleCubit>().setLocale(value!);
              },
            ),
          ],
        ),

        // ── Logout Button ──────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 30),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: BlocProvider(
              create: (context) => sl<LoginCubit>(),
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LogoutSuccess) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login',
                          (route) => false,
                    );
                  } else if (state is LogoutError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red.shade700,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return OutlinedButton.icon(
                    onPressed: state is LogoutLoading
                        ? null
                        : () => context.read<LoginCubit>().logout(),
                    icon: state is LogoutLoading
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : Icon(Icons.logout, color: Colors.red.shade400),
                    label: state is LogoutLoading
                        ? const SizedBox.shrink()
                        : Text(
                      AppLocalizations.of(context).translate('logout'),
                      style: AppTextStyles.headline2
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}