import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vetyo/core/utils/shared_pref.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale("en"));

  // Initialize language from saved preference
  void initializeLanguage() async {
    String savedLanguage = SharedPref.getStringValue('app_language');
    if (savedLanguage.isNotEmpty && ['en', 'ne'].contains(savedLanguage)) {
      emit(Locale(savedLanguage));
    } else {
      // Default to English if no preference saved
      emit(const Locale('en'));
    }
  }

  // Change language and persist the preference
  void changeLanguage(String languageCode) async {
    if (['en', 'ne'].contains(languageCode)) {
      await SharedPref.setStringValue('app_language', languageCode);
      emit(Locale(languageCode));
    }
  }
}

// Keep existing maps for backward compatibility
Map iSOLanguageCode = {"ENG": "en", "NEP": "ne"};

Map lLanguageName = {"en": "ENG", "ne": "NEP"};

getLanguageCode(String language) {
  if (iSOLanguageCode.containsKey(language)) {
    return iSOLanguageCode[language];
  }
}
