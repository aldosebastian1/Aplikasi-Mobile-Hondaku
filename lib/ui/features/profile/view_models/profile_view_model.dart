import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/user_profile.dart';
import '../../../../domain/models/payment_method_item.dart';
import '../../../../domain/models/app_settings.dart';

// Re-export the domain models so they are easy to import via the view model if needed
export '../../../../domain/models/user_profile.dart';
export '../../../../domain/models/payment_method_item.dart';
export '../../../../domain/models/app_settings.dart';

class UserProfileNotifier extends Notifier<UserProfile> {
  @override
  UserProfile build() {
    return const UserProfile(
      nama: 'Alex Rider',
      username: 'alex.rider',
      email: 'alex.rider@hondaku.com',
      phone: '81234567890',
      nik: '1234567890123456',
      avatarPath: 'assets/images/profile.png',
      isCustomAvatar: false,
    );
  }

  void updateProfile({
    required String nama,
    required String username,
    required String email,
    required String phone,
    required String nik,
    String? avatarPath,
    bool? isCustomAvatar,
    Color? avatarBgColor,
  }) {
    String initials = '';
    final names = nama.trim().split(' ');
    if (names.isNotEmpty && names[0].isNotEmpty) {
      initials += names[0][0].toUpperCase();
      if (names.length > 1 && names[1].isNotEmpty) {
        initials += names[1][0].toUpperCase();
      }
    } else {
      initials = 'AR';
    }

    state = state.copyWith(
      nama: nama,
      username: username,
      email: email,
      phone: phone,
      nik: nik,
      avatarPath: avatarPath,
      isCustomAvatar: isCustomAvatar,
      avatarBgColor: avatarBgColor,
      initials: initials,
    );
  }
}

final userProfileProvider = NotifierProvider<UserProfileNotifier, UserProfile>(() {
  return UserProfileNotifier();
});

class PaymentMethodsNotifier extends Notifier<List<PaymentMethodItem>> {
  @override
  List<PaymentMethodItem> build() {
    return const [
      PaymentMethodItem(
        id: 'PM-001',
        title: 'BCA Virtual Account',
        subtitle: 'Bank BCA • Utama',
        logoPath: 'assets/payments/bca.png',
        isDefault: true,
        type: 'VA',
      ),
      PaymentMethodItem(
        id: 'PM-002',
        title: 'Mandiri Virtual Account',
        subtitle: 'Bank Mandiri',
        logoPath: 'assets/payments/mandiri.png',
        isDefault: false,
        type: 'VA',
      ),
    ];
  }

  void setDefaultPayment(String id) {
    state = state.map((item) {
      return item.copyWith(
        isDefault: item.id == id,
        subtitle: item.id == id
            ? '${item.title.split(' ')[0]} • Utama'
            : item.title.split(' ')[0],
      );
    }).toList();
  }

  void addPaymentMethod(PaymentMethodItem item) {
    var current = state;
    if (item.isDefault) {
      current = current.map((e) => e.copyWith(
        isDefault: false,
        subtitle: e.title.split(' ')[0],
      )).toList();
    }
    state = [...current, item];
  }

  void removePaymentMethod(String id) {
    final current = state.where((e) => e.id != id).toList();
    if (current.isNotEmpty && !current.any((e) => e.isDefault)) {
      current[0] = current[0].copyWith(
        isDefault: true,
        subtitle: '${current[0].title.split(' ')[0]} • Utama',
      );
    }
    state = current;
  }
}

final paymentMethodsProvider = NotifierProvider<PaymentMethodsNotifier, List<PaymentMethodItem>>(() {
  return PaymentMethodsNotifier();
});

class AppSettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    return const AppSettings(
      notifEnabled: true,
      biometricEnabled: false,
      darkModeEnabled: false,
      selectedLanguage: 'Bahasa Indonesia',
    );
  }

  void updateSettings({
    bool? notifEnabled,
    bool? biometricEnabled,
    bool? darkModeEnabled,
    String? selectedLanguage,
  }) {
    state = state.copyWith(
      notifEnabled: notifEnabled,
      biometricEnabled: biometricEnabled,
      darkModeEnabled: darkModeEnabled,
      selectedLanguage: selectedLanguage,
    );
  }
}

final appSettingsProvider = NotifierProvider<AppSettingsNotifier, AppSettings>(() {
  return AppSettingsNotifier();
});
