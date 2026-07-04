import 'package:flutter/material.dart';

@immutable
class AppSettings {
  final bool notifEnabled;
  final bool biometricEnabled;
  final String selectedLanguage;

  const AppSettings({
    required this.notifEnabled,
    required this.biometricEnabled,
    required this.selectedLanguage,
  });

  AppSettings copyWith({
    bool? notifEnabled,
    bool? biometricEnabled,
    String? selectedLanguage,
  }) {
    return AppSettings(
      notifEnabled: notifEnabled ?? this.notifEnabled,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}
