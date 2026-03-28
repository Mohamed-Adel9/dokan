import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en')) {
    loadLocale();
  }

  final String _boxName = 'settingsLocale';
  final String _localeKey = 'locale';

  Future<void> loadLocale() async {
    final box = await Hive.openBox(_boxName);
    final savedLocale = box.get(_localeKey);

    if (savedLocale == 'ar') {
      emit(const Locale('ar'));
    } else {
      emit(const Locale('en'));
    }
  }

  Future<void> setLocale(String langCode) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_localeKey, langCode);

    emit(Locale(langCode));
  }
}