import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../domain/models/user_profile.dart';
import '../../../../domain/models/payment_method_item.dart';
import '../../../../domain/models/app_settings.dart';

// Re-export the domain models so they are easy to import via the view model if needed
export '../../../../domain/models/user_profile.dart';
export '../../../../domain/models/payment_method_item.dart';
export '../../../../domain/models/app_settings.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../../data/providers.dart';

class UserProfileNotifier extends Notifier<UserProfile> {

  @override
  UserProfile build() {
    // Watch the auth state so this provider rebuilds when user logs in/out
    final userAsync = ref.watch(authStateProvider);
    
    return userAsync.when(
      data: (User? user) {
        if (user == null) {
          return UserProfile.create(
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
        
        final prefs = ref.watch(sharedPreferencesProvider);
        final cachedColorValue = prefs.getInt('cached_avatar_color_${user.uid}');
        Color? cachedColor = cachedColorValue != null ? Color(cachedColorValue) : null;
        
        final basicProfile = UserProfile.create(
          nama: name,
          username: email.split('@').first,
          email: email,
          phone: phone,
          nik: '-',
          avatarPath: user.photoURL ?? 'assets/images/profile.png',
          isCustomAvatar: user.photoURL != null,
          initials: initials,
          avatarBgColor: cachedColor,
        );

        // Fetch complete profile from Firestore asynchronously
        // Always reset flag if it's a new build cycle triggered by auth state change
        // to ensure we fetch the correct data for the new account
        Future.microtask(() => _fetchFromFirestore(user.uid, basicProfile));

        return basicProfile;
      },
      loading: () => UserProfile.create(
        nama: 'Memuat...',
        username: 'loading',
        email: '...',
        phone: '...',
        nik: '...',
        avatarPath: 'assets/images/profile.png',
        isCustomAvatar: false,
      ),
      error: (error, stackTrace) => UserProfile.create(
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
      avatarPath: avatarPath ?? state.avatarPath,
      isCustomAvatar: isCustomAvatar ?? state.isCustomAvatar,
      avatarBgColor: avatarBgColor ?? state.avatarBgColor,
      initials: initials,
    );

    state = newProfile;

    // Save to Firestore
    final user = ref.read(authStateProvider).value;
    if (user != null) {
      ref.read(userRepositoryProvider).saveUserProfile(user.uid, newProfile);
      
      // Cache avatar color locally
      final prefs = ref.read(sharedPreferencesProvider);
      prefs.setInt('cached_avatar_color_${user.uid}', newProfile.avatarBgColor.toARGB32());
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
        // Ensure we only update state if the current user is still the same
        final currentUser = ref.read(authStateProvider).value;
        if (currentUser?.uid == uid) {
          state = mergedProfile;
          
          // Cache avatar color locally so next app launch is instant
          final prefs = ref.read(sharedPreferencesProvider);
          prefs.setInt('cached_avatar_color_$uid', mergedProfile.avatarBgColor.toARGB32());
        }
      }
    } catch (e) {
      // ignore
    }
  }
}

final userProfileProvider = NotifierProvider<UserProfileNotifier, UserProfile>(() {
  return UserProfileNotifier();
});

class PaymentMethodsNotifier extends Notifier<List<PaymentMethodItem>> {
  @override
  List<PaymentMethodItem> build() {
    final userAsync = ref.watch(authStateProvider);
    
    return userAsync.when(
      data: (user) {
        if (user == null) return [];
        Future.microtask(() => _fetchFromFirestore(user.uid));
        return [];
      },
      loading: () => [],
      error: (_, _) => [],
    );
  }

  Future<void> _fetchFromFirestore(String uid) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('payment_methods')
          .get();
          
      final methods = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return PaymentMethodItem.fromJson(data);
      }).toList();
      
      final currentUser = ref.read(authStateProvider).value;
      if (currentUser?.uid == uid) {
        state = methods;
      }
    } catch (e) {
      // ignore
    }
  }

  Future<void> setDefaultPayment(String id) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;

    final updatedState = state.map((item) {
      return item.copyWith(
        isDefault: item.id == id,
        subtitle: item.id == id
            ? '${item.title.split(' ')[0]} â€¢ Utama'
            : item.title.split(' ')[0].replaceAll(' â€¢ Utama', ''),
      );
    }).toList();
    
    state = updatedState;

    try {
      final batch = FirebaseFirestore.instance.batch();
      final coll = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('payment_methods');
      
      for (var item in updatedState) {
        batch.update(coll.doc(item.id), {'isDefault': item.isDefault, 'subtitle': item.subtitle});
      }
      await batch.commit();
    } catch (e) {
      // ignore
    }
  }

  Future<void> addPaymentMethod(PaymentMethodItem item) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;

    var current = state;
    if (item.isDefault) {
      current = current.map((e) => e.copyWith(
        isDefault: false,
        subtitle: e.title.split(' ')[0].replaceAll(' â€¢ Utama', ''),
      )).toList();
    }
    
    final updatedState = [...current, item];
    state = updatedState;

    try {
      final coll = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('payment_methods');
      final batch = FirebaseFirestore.instance.batch();
      
      if (item.isDefault) {
        for (var oldItem in current) {
          batch.update(coll.doc(oldItem.id), {'isDefault': oldItem.isDefault, 'subtitle': oldItem.subtitle});
        }
      }
      batch.set(coll.doc(item.id), item.toJson());
      await batch.commit();
    } catch (e) {
      // ignore
    }
  }

  Future<void> removePaymentMethod(String id) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;

    final current = state.where((e) => e.id != id).toList();
    if (current.isNotEmpty && !current.any((e) => e.isDefault)) {
      current[0] = current[0].copyWith(
        isDefault: true,
        subtitle: '${current[0].title.split(' ')[0]} â€¢ Utama',
      );
    }
    state = current;

    try {
      final coll = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('payment_methods');
      final batch = FirebaseFirestore.instance.batch();
      
      batch.delete(coll.doc(id));
      if (current.isNotEmpty && current[0].isDefault) {
        batch.update(coll.doc(current[0].id), {'isDefault': current[0].isDefault, 'subtitle': current[0].subtitle});
      }
      await batch.commit();
    } catch (e) {
      // ignore
    }
  }
}

final paymentMethodsProvider = NotifierProvider<PaymentMethodsNotifier, List<PaymentMethodItem>>(() {
  return PaymentMethodsNotifier();
});

class AppSettingsNotifier extends Notifier<AppSettings> {
  static const _notifKey = 'app_notif_enabled';
  static const _biometricKey = 'app_biometric_enabled';
  static const _langKey = 'app_selected_language';

  @override
  AppSettings build() {
    Future.microtask(_loadSettings);
    return const AppSettings(
      notifEnabled: true,
      biometricEnabled: false,
      selectedLanguage: 'Bahasa Indonesia',
    );
  }

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final notif = prefs.getBool(_notifKey) ?? true;
      final biometric = prefs.getBool(_biometricKey) ?? false;
      final lang = prefs.getString(_langKey) ?? 'Bahasa Indonesia';

      state = AppSettings(
        notifEnabled: notif,
        biometricEnabled: biometric,
        selectedLanguage: lang,
      );
    } catch (e) {
      // ignore
    }
  }

  Future<void> updateSettings({
    bool? notifEnabled,
    bool? biometricEnabled,
    String? selectedLanguage,
  }) async {
    final newState = state.copyWith(
      notifEnabled: notifEnabled ?? state.notifEnabled,
      biometricEnabled: biometricEnabled ?? state.biometricEnabled,
      selectedLanguage: selectedLanguage ?? state.selectedLanguage,
    );
    state = newState;

    try {
      final prefs = await SharedPreferences.getInstance();
      if (notifEnabled != null) await prefs.setBool(_notifKey, notifEnabled);
      if (biometricEnabled != null) await prefs.setBool(_biometricKey, biometricEnabled);
      if (selectedLanguage != null) await prefs.setString(_langKey, selectedLanguage);
    } catch (e) {
      // ignore
    }
  }
}

final appSettingsProvider = NotifierProvider<AppSettingsNotifier, AppSettings>(() {
  return AppSettingsNotifier();
});
