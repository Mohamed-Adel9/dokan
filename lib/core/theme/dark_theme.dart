import 'package:dokan/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    // 🌍 Scaffold
    scaffoldBackgroundColor: AppColors.darkBackground,

    // 🎨 Color Scheme (VERY IMPORTANT)
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,

      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,

      surface: AppColors.dark,        // cards / containers
      onSurface: AppColors.white,     // text/icons on surface

      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onError: AppColors.white,
    ),

    // 🧭 AppBar
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.white,
      centerTitle: true,
    ),


    // 🔘 Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        padding: const EdgeInsets.all( 14),
        alignment: Alignment.center,
      ),
    ),

    // 🔘 Outlined Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),

    // 🧾 Input Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.dark, // 👈 مهم في الدارك
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.grey.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    ),

    // 🧱 Cards
    cardTheme: CardThemeData(
      color: AppColors.dark,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    // 📱 Bottom Navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.dark,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      elevation: 10,
      type: BottomNavigationBarType.fixed,
    ),

    // 📊 Divider
    dividerTheme: DividerThemeData(
      color: AppColors.grey.withValues(alpha: 0.3),
      thickness: 0.8,
    ),

    // 🔘 Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.primary),
      checkColor: WidgetStatePropertyAll(AppColors.white),
    ),

    // 🔘 Radio
    radioTheme: RadioThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.primary),
    ),

    // 🔄 Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(AppColors.primary),
      trackColor: WidgetStatePropertyAll(AppColors.primary.withValues(alpha: 0.4))
    ),

    // 🎯 Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.white,
    ),

    // 🎯 IconButton Theme
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(AppColors.white),
        overlayColor:WidgetStatePropertyAll(AppColors.primary.withValues(alpha: 0.4),
        ),
      ),
    ),
  );
}