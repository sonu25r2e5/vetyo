import 'package:flutter/material.dart';
import 'package:vetyo/generated/l10n/app_localizations.dart';

/// Helper class for traditional AppLocalizations access.
class AppTranslations {
  static String greeting(BuildContext context) {
    return AppLocalizations.of(context).greeting;
  }
}

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
