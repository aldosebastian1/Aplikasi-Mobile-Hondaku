import 'package:flutter/material.dart';

@immutable
class AppSettings {
  final bool notifEnabled;
  final bool biometricEnabled;
  final bool darkModeEnabled;
  final String selectedLanguage;

  const AppSettings({
    required this.notifEnabled,
    required this.biometricEnabled,
    required this.darkModeEnabled,
    required this.selectedLanguage,
  });

  AppSettings copyWith({
    bool? notifEnabled,
    bool? biometricEnabled,
    bool? darkModeEnabled,
    String? selectedLanguage,
  }) {
    return AppSettings(
      notifEnabled: notifEnabled ?? this.notifEnabled,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}
