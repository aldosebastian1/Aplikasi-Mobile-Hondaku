import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/user_profile.dart';
import '../../../../domain/models/payment_method_item.dart';
import '../../../../domain/models/app_settings.dart';

// Re-export the domain models so they are easy to import via the view model if needed
export '../../../../domain/models/user_profile.dart';
export '../../../../domain/models/payment_method_item.dart';
export '../../../../domain/models/app_settings.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../../data/providers.dart';

class UserProfileNotifier extends Notifier<UserProfile> {
  bool _isFetching = false;

  @override
  UserProfile build() {
    // Watch the auth state so this provider rebuilds when user logs in/out
    final userAsync = ref.watch(authStateProvider);
    
    return userAsync.when(
      data: (User? user) {
        if (user == null) {
          return UserProfile(
            nama: 'Guest',
            username: 'guest',
            email: '-',
            phone: '-',
            nik: '-',
            avatarPath: 'assets/images/profile.png',
            isCustomAvatar: false,
          );
        }
        
        final name = user.displayName ?? 'Pengguna Hondaku';
        final email = user.email ?? '-';
        final phone = user.phoneNumber ?? '-';
        
        String initials = '';
        final names = name.trim().split(' ');
        if (names.isNotEmpty && names[0].isNotEmpty) {
          initials += names[0][0].toUpperCase();
          if (names.length > 1 && names[1].isNotEmpty) {
            initials += names[1][0].toUpperCase();
          }
        } else {
          initials = 'PH';
        }
        
        final basicProfile = UserProfile(
          nama: name,
          username: email.split('@').first,
          email: email,
          phone: phone,
          nik: '-',
          avatarPath: user.photoURL ?? 'assets/images/profile.png',
          isCustomAvatar: user.photoURL != null,
          initials: initials,
        );

        // Fetch complete profile from Firestore asynchronously
        if (!_isFetching) {
          _isFetching = true;
          Future.microtask(() => _fetchFromFirestore(user.uid, basicProfile));
        }

        return basicProfile;
      },
      loading: () => UserProfile(
        nama: 'Memuat...',
        username: 'loading',
        email: '...',
        phone: '...',
        nik: '...',
        avatarPath: 'assets/images/profile.png',
        isCustomAvatar: false,
      ),
      error: (error, stackTrace) => UserProfile(
        nama: 'Error',
        username: 'error',
        email: 'error',
        phone: 'error',
        nik: 'error',
        avatarPath: 'assets/images/profile.png',
        isCustomAvatar: false,
      ),
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
      initials = 'PH';
    }

    final newProfile = state.copyWith(
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

    state = newProfile;

    // Save to Firestore
    final user = ref.read(authStateProvider).value;
    if (user != null) {
      ref.read(userRepositoryProvider).saveUserProfile(user.uid, newProfile);
    }
  }

  Future<void> _fetchFromFirestore(String uid, UserProfile basicProfile) async {
    try {
      final repo = ref.read(userRepositoryProvider);
      final profile = await repo.getUserProfile(uid);
      if (profile != null) {
        // Merge avatar from Auth if customAvatar is false
        final mergedProfile = profile.copyWith(
          avatarPath: profile.isCustomAvatar ? profile.avatarPath : basicProfile.avatarPath,
          email: basicProfile.email.isNotEmpty ? basicProfile.email : profile.email,
        );
        state = mergedProfile;
      }
    } catch (e) {
      // ignore
    } finally {
      _isFetching = false;
    }
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
