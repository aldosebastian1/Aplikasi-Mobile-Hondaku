import 'package:flutter/material.dart';

@immutable
class UserProfile {
  final String nama;
  final String username;
  final String email;
  final String phone;
  final String nik;
  final String avatarPath;
  final bool isCustomAvatar;
  final Color avatarBgColor;
  final String initials;

  const UserProfile({
    required this.nama,
    required this.username,
    required this.email,
    required this.phone,
    required this.nik,
    required this.avatarPath,
    this.isCustomAvatar = false,
    this.avatarBgColor = const Color(0xFFC40000),
    this.initials = 'AR',
  });

  UserProfile copyWith({
    String? nama,
    String? username,
    String? email,
    String? phone,
    String? nik,
    String? avatarPath,
    bool? isCustomAvatar,
    Color? avatarBgColor,
    String? initials,
  }) {
    return UserProfile(
      nama: nama ?? this.nama,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      nik: nik ?? this.nik,
      avatarPath: avatarPath ?? this.avatarPath,
      isCustomAvatar: isCustomAvatar ?? this.isCustomAvatar,
      avatarBgColor: avatarBgColor ?? this.avatarBgColor,
      initials: initials ?? this.initials,
    );
  }
}

@immutable
class PaymentMethodItem {
  final String id;
  final String title;
  final String subtitle;
  final String logoPath;
  final bool isDefault;
  final String type; // e.g., 'VA', 'CARD', 'EWALLET'

  const PaymentMethodItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.logoPath,
    required this.isDefault,
    required this.type,
  });

  PaymentMethodItem copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? logoPath,
    bool? isDefault,
    String? type,
  }) {
    return PaymentMethodItem(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      logoPath: logoPath ?? this.logoPath,
      isDefault: isDefault ?? this.isDefault,
      type: type ?? this.type,
    );
  }
}

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

class UserStore {
  // 1. Profile State
  static final ValueNotifier<UserProfile> profile = ValueNotifier<UserProfile>(
    const UserProfile(
      nama: 'Alex Rider',
      username: 'alex.rider',
      email: 'alex.rider@hondaku.com',
      phone: '81234567890',
      nik: '1234567890123456',
      avatarPath: 'assets/images/profile.png',
      isCustomAvatar: false,
    ),
  );

  static Widget buildReactiveAvatar({double radius = 20, double fontSize = 12}) {
    return ValueListenableBuilder<UserProfile>(
      valueListenable: profile,
      builder: (context, userProfile, _) {
        if (userProfile.isCustomAvatar) {
          return CircleAvatar(
            radius: radius,
            backgroundColor: userProfile.avatarBgColor,
            child: Text(
              userProfile.initials,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
          );
        } else {
          if (userProfile.avatarPath.startsWith('http')) {
            return CircleAvatar(
              radius: radius,
              backgroundImage: NetworkImage(userProfile.avatarPath),
            );
          } else {
            return CircleAvatar(
              radius: radius,
              backgroundImage: AssetImage(userProfile.avatarPath),
            );
          }
        }
      },
    );
  }

  static void updateProfile({
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

    profile.value = profile.value.copyWith(
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

  // 2. Payment Methods State
  static final ValueNotifier<List<PaymentMethodItem>> paymentMethods = ValueNotifier<List<PaymentMethodItem>>([
    const PaymentMethodItem(
      id: 'PM-001',
      title: 'BCA Virtual Account',
      subtitle: 'Bank BCA • Utama',
      logoPath: 'assets/payments/bca.png',
      isDefault: true,
      type: 'VA',
    ),
    const PaymentMethodItem(
      id: 'PM-002',
      title: 'Mandiri Virtual Account',
      subtitle: 'Bank Mandiri',
      logoPath: 'assets/payments/mandiri.png',
      isDefault: false,
      type: 'VA',
    ),
  ]);

  static void setDefaultPayment(String id) {
    final current = List<PaymentMethodItem>.from(paymentMethods.value);
    for (int i = 0; i < current.length; i++) {
      current[i] = current[i].copyWith(
        isDefault: current[i].id == id,
        subtitle: current[i].id == id
            ? '${current[i].title.split(' ')[0]} • Utama'
            : current[i].title.split(' ')[0],
      );
    }
    paymentMethods.value = current;
  }

  static void addPaymentMethod(PaymentMethodItem item) {
    final current = List<PaymentMethodItem>.from(paymentMethods.value);
    if (item.isDefault) {
      for (int i = 0; i < current.length; i++) {
        current[i] = current[i].copyWith(
          isDefault: false,
          subtitle: current[i].title.split(' ')[0],
        );
      }
    }
    current.add(item);
    paymentMethods.value = current;
  }

  static void removePaymentMethod(String id) {
    final current = List<PaymentMethodItem>.from(paymentMethods.value);
    current.removeWhere((element) => element.id == id);
    if (current.isNotEmpty && !current.any((e) => e.isDefault)) {
      current[0] = current[0].copyWith(
        isDefault: true,
        subtitle: '${current[0].title.split(' ')[0]} • Utama',
      );
    }
    paymentMethods.value = current;
  }

  // 3. Settings State
  static final ValueNotifier<AppSettings> settings = ValueNotifier<AppSettings>(
    const AppSettings(
      notifEnabled: true,
      biometricEnabled: false,
      darkModeEnabled: false,
      selectedLanguage: 'Bahasa Indonesia',
    ),
  );

  static void updateSettings({
    bool? notifEnabled,
    bool? biometricEnabled,
    bool? darkModeEnabled,
    String? selectedLanguage,
  }) {
    settings.value = settings.value.copyWith(
      notifEnabled: notifEnabled,
      biometricEnabled: biometricEnabled,
      darkModeEnabled: darkModeEnabled,
      selectedLanguage: selectedLanguage,
    );
  }
}
