import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    loadTheme();
  }

  final String _boxName = 'settings';
  final String _themeKey = 'theme';

  Future<void> loadTheme() async {
    final box = await Hive.openBox(_boxName);
    final savedTheme = box.get(_themeKey);

    if (savedTheme == 'light') {
      emit(ThemeMode.light);
    } else if (savedTheme == 'dark') {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.system);
    }
  }

  Future<void> setLight() async {
    final box = await Hive.openBox(_boxName);
    await box.put(_themeKey, 'light');
    emit(ThemeMode.light);
  }

  Future<void> setDark() async {
    final box = await Hive.openBox(_boxName);
    await box.put(_themeKey, 'dark');
    emit(ThemeMode.dark);
  }

  Future<void> setSystem() async {
    final box = await Hive.openBox(_boxName);
    await box.put(_themeKey, 'system');
    emit(ThemeMode.system);
  }

  bool get isDark => state == ThemeMode.dark;
}